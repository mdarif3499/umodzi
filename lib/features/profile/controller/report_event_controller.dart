import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umodzi/config/route/app_routes.dart';
import '../../../config/api/api_end_point.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/api_service.dart';
import '../../../services/api/multipart_helper.dart';
import '../../../utils/app_snackbar.dart';
import '../screen/report_success_screen.dart';

class ReportEventController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();

  // For event type fetching
  RxList<dynamic> fetchedEventTypes = <dynamic>[].obs;
  RxString selectedEventTypeId = ''.obs;
  RxString selectedEventTypeName = ''.obs;
  
  RxString selectedFileName = ''.obs;
  RxString selectedFilePath = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isFetchingTypes = false.obs;

  final ApiClient apiClient = DioApiClient();

  @override
  void onInit() {
    super.onInit();
    getEventTypes();
  }


  Future<void> getEventTypes() async {
    try {
      isFetchingTypes.value = true;
      final response = await apiClient.get(ApiEndPoint.eventTypes);
      
      if (response.isSuccess) {
        final data = response.data['data'];
        if (data is List) {
          fetchedEventTypes.assignAll(data);
        }
      }
    } catch (e) {
      debugPrint("Error fetching event types: $e");
    } finally {
      isFetchingTypes.value = false;
    }
  }

  // --- Date Picker ---
  void pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      dateController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}T00:00:00.000Z";
    }
  }

  Future<void> showFilePickerOptions() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'ppt', 'pptx', 'txt', 'rtf', 'zip', '7z', 'rar', 'png', 'jpg', 'jpeg'],
      );

      if (result != null && result.files.single.path != null) {
        selectedFileName.value = result.files.single.name;
        selectedFilePath.value = result.files.single.path!;
      }
    } catch (e) {
      AppSnackbar.error(title: "Error", message: "Could not pick file: $e");
    }
  }

  Future<void> submitReport() async {
    if (titleController.text.isEmpty ||
        selectedEventTypeId.value.isEmpty ||
        descriptionController.text.isEmpty ||
        dateController.text.isEmpty) {
      AppSnackbar.error(title: 'Error', message: 'Please fill all fields');
      return;
    }

    try {
      isLoading.value = true;

      Map<String, String> bodyData = {
        'name': titleController.text.trim(),
        'eventTypeId': selectedEventTypeId.value,
        'description': descriptionController.text.trim(),
        'eventDate': dateController.text.trim(),
      };

      List<MultipartFileItem> files = [];
      if (selectedFilePath.value.isNotEmpty) {
        files.add(MultipartFileItem(
          filePath: selectedFilePath.value,
          fileName: 'document',
        ));
      }

      final response = await apiClient.multipart(
        url: ApiEndPoint.createEventReport,
        method: 'POST',
        files: files,
        body: bodyData,
      );

      if (response.isSuccess) {
        Get.toNamed((AppRoutes.navBarScreen)  );
        _clearFields();
      } else {
        AppSnackbar.error(title: 'Error', message: response.message);
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _clearFields() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
    selectedEventTypeId.value = '';
    selectedEventTypeName.value = '';
    selectedFileName.value = '';
    selectedFilePath.value = '';
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.onClose();
  }
}
