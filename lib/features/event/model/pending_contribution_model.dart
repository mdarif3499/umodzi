class PendingContributionModel {
  final bool? success;
  final String? message;
  final int? statusCode;
  final List<PendingContribution>? data;

  PendingContributionModel({
    this.success,
    this.message,
    this.statusCode,
    this.data,
  });

  factory PendingContributionModel.fromJson(Map<String, dynamic> json) => PendingContributionModel(
    success: json["success"],
    message: json["message"],
    statusCode: json["statusCode"],
    data: json["data"] == null ? [] : List<PendingContribution>.from(json["data"].map((x) => PendingContribution.fromJson(x))),
  );
}

class PendingContribution {
  final String? contributionId;
  final String? eventId;
  final String? eventName;
  final String? eventType;
  final String? banner;
  final double? amountDue;
  final double? penaltyApplied;
  final double? totalDue;
  final DateTime? deadline;
  final int? daysLeft;
  final String? status;
  final String? badge;

  PendingContribution({
    this.contributionId,
    this.eventId,
    this.eventName,
    this.eventType,
    this.banner,
    this.amountDue,
    this.penaltyApplied,
    this.totalDue,
    this.deadline,
    this.daysLeft,
    this.status,
    this.badge,
  });

  factory PendingContribution.fromJson(Map<String, dynamic> json) => PendingContribution(
    contributionId: json["contributionId"],
    eventId: json["eventId"],
    eventName: json["eventName"],
    eventType: json["eventType"],
    banner: json["banner"],
    amountDue: json["amountDue"]?.toDouble(),
    penaltyApplied: json["penaltyApplied"]?.toDouble(),
    totalDue: json["totalDue"]?.toDouble(),
    deadline: json["deadline"] == null ? null : DateTime.parse(json["deadline"]),
    daysLeft: json["daysLeft"],
    status: json["status"],
    badge: json["badge"],
  );
}
