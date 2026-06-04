class RecentTransactionModel {
  bool? success;
  String? message;
  int? statusCode;
  List<RecentTransaction>? data;

  RecentTransactionModel({this.success, this.message, this.statusCode, this.data});

  RecentTransactionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <RecentTransaction>[];
      json['data'].forEach((v) {
        data!.add(RecentTransaction.fromJson(v));
      });
    }
  }
}

class RecentTransaction {
  String? id;
  String? userId;
  String? type;
  double? amount;
  EventId? eventId;
  ContributionId? contributionId;
  String? stripePaymentIntentId;
  String? stripeCheckoutSessionId;
  String? note;
  DateTime? createdAt;
  DateTime? updatedAt;

  RecentTransaction(
      {this.id,
      this.userId,
      this.type,
      this.amount,
      this.eventId,
      this.contributionId,
      this.stripePaymentIntentId,
      this.stripeCheckoutSessionId,
      this.note,
      this.createdAt,
      this.updatedAt});

  RecentTransaction.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    type = json['type'];
    amount = json['amount']?.toDouble();
    eventId =
        json['eventId'] != null ? EventId.fromJson(json['eventId']) : null;
    contributionId = json['contributionId'] != null
        ? ContributionId.fromJson(json['contributionId'])
        : null;
    stripePaymentIntentId = json['stripePaymentIntentId'];
    stripeCheckoutSessionId = json['stripeCheckoutSessionId'];
    note = json['note'];
    createdAt = json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null;
    updatedAt = json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null;
  }
}

class EventId {
  String? id;
  String? name;
  String? eventType;
  String? banner;

  EventId({this.id, this.name, this.eventType, this.banner});

  EventId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    eventType = json['eventType'];
    banner = json['banner'];
  }
}

class ContributionId {
  String? id;
  double? amountDue;
  int? penaltyApplied;
  String? status;

  ContributionId({this.id, this.amountDue, this.penaltyApplied, this.status});

  ContributionId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    amountDue = json['amountDue']?.toDouble();
    penaltyApplied = json['penaltyApplied'];
    status = json['status'];
  }
}
