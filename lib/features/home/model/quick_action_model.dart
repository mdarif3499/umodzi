class QuickActionModel {
  final bool? success;
  final String? message;
  final int? statusCode;
  final QuickActionData? data;

  QuickActionModel({
    this.success,
    this.message,
    this.statusCode,
    this.data,
  });

  factory QuickActionModel.fromJson(Map<String, dynamic> json) => QuickActionModel(
    success: json["success"],
    message: json["message"],
    statusCode: json["statusCode"],
    data: json["data"] == null ? null : QuickActionData.fromJson(json["data"]),
  );
}

class QuickActionData {
  final int? dependenceCount;
  final int? transactionCount;
  final int? totalParticipants;

  QuickActionData({
    this.dependenceCount,
    this.transactionCount,
    this.totalParticipants,
  });

  factory QuickActionData.fromJson(Map<String, dynamic> json) => QuickActionData(
    dependenceCount: json["dependenceCount"],
    transactionCount: json["transactionCount"],
    totalParticipants: json["totalParticipants"],
  );
}
