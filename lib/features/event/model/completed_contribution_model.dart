class CompletedContributionModel {
  final bool? success;
  final String? message;
  final int? statusCode;
  final List<CompletedContribution>? data;

  CompletedContributionModel({
    this.success,
    this.message,
    this.statusCode,
    this.data,
  });

  factory CompletedContributionModel.fromJson(Map<String, dynamic> json) => CompletedContributionModel(
    success: json["success"],
    message: json["message"],
    statusCode: json["statusCode"],
    data: json["data"] == null ? [] : List<CompletedContribution>.from(json["data"].map((x) => CompletedContribution.fromJson(x))),
  );
}

class CompletedContribution {
  final String? contributionId;
  final String? eventId;
  final String? eventName;
  final String? eventType;
  final String? banner;
  final int? amountPaid;
  final DateTime? paidAt;
  final String? status;

  CompletedContribution({
    this.contributionId,
    this.eventId,
    this.eventName,
    this.eventType,
    this.banner,
    this.amountPaid,
    this.paidAt,
    this.status,
  });

  factory CompletedContribution.fromJson(Map<String, dynamic> json) => CompletedContribution(
    contributionId: json["contributionId"],
    eventId: json["eventId"],
    eventName: json["eventName"],
    eventType: json["eventType"],
    banner: json["banner"],
    amountPaid: json["amountPaid"],
    paidAt: json["paidAt"] == null ? null : DateTime.parse(json["paidAt"]),
    status: json["status"],
  );
}
