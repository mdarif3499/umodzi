class NotificationModel {
  bool? success;
  String? message;
  int? statusCode;
  NotificationData? data;
  Meta? meta;

  NotificationModel({this.success, this.message, this.statusCode, this.data, this.meta});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? NotificationData.fromJson(json['data']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}

class NotificationData {
  List<NotificationItem>? result;
  int? unreadCount;

  NotificationData({this.result, this.unreadCount});

  NotificationData.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <NotificationItem>[];
      json['result'].forEach((v) {
        result!.add(NotificationItem.fromJson(v));
      });
    }
    unreadCount = json['unreadCount'];
  }
}

class NotificationItem {
  String? id;
  String? title;
  String? message;
  String? receiver;
  dynamic reference;
  bool? read;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotificationItem({
    this.id,
    this.title,
    this.message,
    this.receiver,
    this.reference,
    this.read,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  NotificationItem.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    message = json['message'];
    receiver = json['receiver'];
    reference = json['reference'];
    read = json['read'];
    type = json['type'];
    createdAt = json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null;
    updatedAt = json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null;
  }
}

class Meta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  Meta({this.page, this.limit, this.total, this.totalPage});

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPage = json['totalPage'];
  }
}
