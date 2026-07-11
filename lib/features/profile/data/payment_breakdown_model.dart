class PaymentBreakdownModel {
  bool? success;
  String? message;
  int? statusCode;
  PaymentBreakdownData? data;

  PaymentBreakdownModel({this.success, this.message, this.statusCode, this.data});
  PaymentBreakdownModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? PaymentBreakdownData.fromJson(json['data']) : null;
  }
}
class PaymentBreakdownData {
  String? status;
  List<BreakdownItem>? breakdown;
  Summary? summary;
  dynamic reinstatementInfo;

  PaymentBreakdownData({this.status, this.breakdown, this.summary, this.reinstatementInfo});

  PaymentBreakdownData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['breakdown'] != null) {
      breakdown = <BreakdownItem>[];
      json['breakdown'].forEach((v) {
        breakdown!.add(BreakdownItem.fromJson(v));
      });
    }
    summary = json['summary'] != null ? Summary.fromJson(json['summary']) : null;
    reinstatementInfo = json['reinstatementInfo'];
  }
}

class BreakdownItem {
  String? contributionId;
  String? eventName;
  String? eventType;
  String? totalParticipatedEvents;
  DateTime? deadlinePassed;
  num? minContribution;
  num? penaltyFee;
  num? totalDue;

  BreakdownItem({
    this.totalParticipatedEvents,
    this.contributionId,
    this.eventName,
    this.eventType,
    this.deadlinePassed,
    this.minContribution,
    this.penaltyFee,
    this.totalDue,
  });

  BreakdownItem.fromJson(Map<String, dynamic> json) {
    contributionId = json['contributionId'];
    totalParticipatedEvents = json['totalParticipatedEvents'];
    eventName = json['eventName'];
    eventType = json['eventType'];
    deadlinePassed = json['deadlinePassed'] != null ? DateTime.tryParse(json['deadlinePassed']) : null;
    minContribution = json['minContribution'];
    penaltyFee = json['penaltyFee'];
    totalDue = json['totalDue'];
  }
}

class Summary {
  num? totalEventDues;
  num? totalParticipatedEvents;
  num? totalPenaltyFee;
  num? reactivationAmount;
  num? grandTotal;

  Summary({this.totalEventDues, this.totalParticipatedEvents, this.totalPenaltyFee, this.reactivationAmount, this.grandTotal});

  Summary.fromJson(Map<String, dynamic> json) {
    totalEventDues = json['totalEventDues'];
    totalParticipatedEvents = json['totalParticipatedEvents'];
    totalPenaltyFee = json['totalPenaltyFee'];
    reactivationAmount = json['reactivationAmount'];
    grandTotal = json['grandTotal'];
  }
}
