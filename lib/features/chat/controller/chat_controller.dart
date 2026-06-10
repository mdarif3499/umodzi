import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../services/socket/socket_service.dart';
import '../../../services/storage/storage_services.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/api_service.dart';
import '../../../services/api/api_response_model.dart';
import '../../../services/api/multipart_helper.dart';
import '../model/message_model.dart';

class ChatController extends GetxController {
  final ApiClient _apiClient = DioApiClient();
  final messageController = TextEditingController();
  final scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  
  var messages = <MessageModel>[].obs;
  var isLoading = false.obs;
  var isSending = false.obs;
  var selectedImages = <File>[].obs;
  String? chatId;

  var adminName = "Administrator".obs;
  var adminImage = "".obs;

  @override
  void onInit() {
    super.onInit();
    chatId = Get.arguments?['chatId'];
    if (chatId != null) {
      fetchMessages();
      _setupSocketListener();
    }
  }

  Future<void> pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      selectedImages.addAll(pickedFiles.map((file) => File(file.path)));
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  Future<void> fetchMessages() async {
    if (chatId == null) return;
    isLoading.value = true;
    try {
      final response = await _apiClient.get('/messages/$chatId');
      if (response.statusCode == 200) {
        final data = response.data['data'];
        
        if (data['chat'] != null && data['chat']['participants'] != null) {
          List participants = data['chat']['participants'];
          for (var p in participants) {
            if (p['role'] == 'ADMIN' || p['role'] == 'SUPER_ADMIN') {
              adminName.value = p['name'] ?? "Administrator";
              adminImage.value = p['image'] ?? "";
              break;
            }
          }
        }
        final List rawMessages = data['messages'] ?? [];
        final String currentId = LocalStorage.userId.trim();
        log("..............................................$currentId");

        messages.value = rawMessages
            .map((m) => MessageModel.fromJson(m, currentId))
            .toList();
      }
    } catch (e) {
      debugPrint('Error fetching messages: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _setupSocketListener() {
    final String userId = LocalStorage.userId.trim();
    if (userId.isEmpty) return;

    SocketService.on('newMessage::$userId', (data) {
      if (data != null) {
        final newMessage = MessageModel.fromJson(data, userId);
        if (newMessage.chatId == chatId) {
          bool exists = messages.any((m) => m.id == newMessage.id);
          if (!exists) {
            messages.insert(0, newMessage);
          }
        }
      }
    });
  }

  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty && selectedImages.isEmpty) return;
    if (chatId == null) return;

    final String userId = LocalStorage.userId.trim();
    isSending.value = true;
    try {
      final String type = selectedImages.isNotEmpty ? "image" : "text";
      final url = '/messages/send/$chatId';
      
      final Map<String, String> body = {
        'message': text,
        'type': type,
      };

      ApiResponseModel response;

      if (selectedImages.isNotEmpty) {
        List<MultipartFileItem> files = selectedImages.map<MultipartFileItem>((file) {
          return MultipartFileItem(fileName: 'images', filePath: file.path);
        }).toList();

        response = await _apiClient.multipart(
          url: url,
          files: files,
          body: body,
        );
      } else {
        response = await _apiClient.post(url, body: body);
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
           final sentMsg = MessageModel.fromJson(response.data['data'], userId, forceMe: true);
           if (!messages.any((m) => m.id == sentMsg.id)) {
             messages.insert(0, sentMsg);
           }
        }
        messageController.clear();
        selectedImages.clear();
      }
    } catch (e) {
      debugPrint('Error sending message: $e');
    } finally {
      isSending.value = false;
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
