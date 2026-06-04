import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../services/storage/storage_services.dart';

class MessageModel {
  final String? id;
  final String? chatId;
  final String text;
  final bool isMe;
  final String time;
  final String? senderId;
  final String? senderName;
  final String? senderImage;
  final List<String>? images;
  final String? type;

  MessageModel({
    this.id,
    this.chatId,
    required this.text,
    required this.isMe,
    required this.time,
    this.senderId,
    this.senderName,
    this.senderImage,
    this.images,
    this.type,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json, String currentUserId, {bool? forceMe}) {
    // If we explicitly know it's our message (e.g., during sendMessage call)
    if (forceMe == true) {
      return _createModel(json, true);
    }

    final dynamic senderData = json['sender'] ?? json['senderId'] ?? json['sender_id'];
    String? sId;
    String? sName;

    if (senderData is Map) {
      sId = (senderData['_id'] ?? senderData['id'])?.toString();
      sName = senderData['name']?.toString();
    } else {
      sId = senderData?.toString();
    }

    // Logic: Identify "Me" primarily by Name, fallback to ID
    // Default to true (Right side) to ensure newly sent messages stay on right
    bool isMeResult = true; 
    
    // 1. Check by Name (As per user request: "name nujay left side korb")
    if (sName != null && sName.isNotEmpty) {
      String name = sName.toLowerCase().trim();
      // Only "Administrator" or "Admin" goes to the Left side
      if (name == "administrator" || name == "admin" || name.contains("admin")) {
        isMeResult = false; 
      } else {
        isMeResult = true; // Any other name (including yours) stays on Right
      }
    } 
    // 2. Check by ID (Fallback if name is missing in socket payload)
    else if (sId != null && sId.isNotEmpty) {
      final String myId = currentUserId.isNotEmpty ? currentUserId : LocalStorage.userId;
      if (myId.isNotEmpty && sId.trim() != myId.trim()) {
        isMeResult = false; // Only goes to Left if ID explicitly belongs to someone else
      }
    }

    return _createModel(json, isMeResult, sId: sId, sName: sName);
  }

  static MessageModel _createModel(Map<String, dynamic> json, bool isMe, {String? sId, String? sName}) {
    String formattedTime = "";
    if (json['createdAt'] != null) {
      try {
        DateTime dateTime = DateTime.parse(json['createdAt'].toString()).toLocal();
        formattedTime = DateFormat('hh:mm a').format(dateTime);
      } catch (e) {
        formattedTime = "";
      }
    }

    return MessageModel(
      id: json['_id']?.toString() ?? json['id']?.toString(),
      chatId: json['chatId']?.toString(),
      text: json['message']?.toString() ?? '',
      senderId: sId,
      senderName: sName,
      senderImage: json['sender'] is Map ? json['sender']['image']?.toString() : null,
      isMe: isMe,
      time: formattedTime,
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      type: json['type']?.toString(),
    );
  }
}
