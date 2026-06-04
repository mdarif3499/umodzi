class TransactionModel {
  final bool? success;
  final String? message;
  final int? statusCode;
  final List<TransactionData>? data;
  final Meta? meta;

  TransactionModel({
    this.success,
    this.message,
    this.statusCode,
    this.data,
    this.meta,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
    success: json["success"],
    message: json["message"],
    statusCode: json["statusCode"],
    data: json["data"] == null ? [] : List<TransactionData>.from(json["data"].map((x) => TransactionData.fromJson(x))),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );
}

class TransactionData {
  final String? id;
  final String? userId;
  final String? type;
  final double? amount;
  final EventId? eventId;
  final ContributionId? contributionId;
  final String? stripePaymentIntentId;
  final String? stripeCheckoutSessionId;
  final String? note;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TransactionData({
    this.id,
    this.userId,
    this.type,
    this.amount,
    this.eventId,
    this.contributionId,
    this.stripePaymentIntentId,
    this.stripeCheckoutSessionId,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) => TransactionData(
    id: json["_id"],
    userId: json["userId"],
    type: json["type"],
    amount: json["amount"]?.toDouble(),
    eventId: json["eventId"] == null ? null : EventId.fromJson(json["eventId"]),
    contributionId: json["contributionId"] == null ? null : ContributionId.fromJson(json["contributionId"]),
    stripePaymentIntentId: json["stripePaymentIntentId"],
    stripeCheckoutSessionId: json["stripeCheckoutSessionId"],
    note: json["note"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );
}

class ContributionId {
  final String? id;
  final double? amountDue;
  final double? penaltyApplied;
  final String? status;

  ContributionId({
    this.id,
    this.amountDue,
    this.penaltyApplied,
    this.status,
  });

  factory ContributionId.fromJson(Map<String, dynamic> json) => ContributionId(
    id: json["_id"],
    amountDue: json["amountDue"]?.toDouble(),
    penaltyApplied: json["penaltyApplied"]?.toDouble(),
    status: json["status"],
  );
}

class EventId {
  final String? id;
  final String? name;
  final String? eventType;
  final String? banner;

  EventId({
    this.id,
    this.name,
    this.eventType,
    this.banner,
  });

  factory EventId.fromJson(Map<String, dynamic> json) => EventId(
    id: json["_id"],
    name: json["name"],
    eventType: json["eventType"],
    banner: json["banner"],
  );
}

class Meta {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  Meta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    page: json["page"],
    limit: json["limit"],
    total: json["total"],
    totalPage: json["totalPage"],
  );
}
