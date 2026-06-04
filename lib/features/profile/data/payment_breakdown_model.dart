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
  List<dynamic>? breakdown;
  Summary? summary;
  dynamic reinstatementInfo;

  PaymentBreakdownData({this.status, this.breakdown, this.summary, this.reinstatementInfo});

  PaymentBreakdownData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    breakdown = json['breakdown'];
    summary = json['summary'] != null ? Summary.fromJson(json['summary']) : null;
    reinstatementInfo = json['reinstatementInfo'];
  }
}

class Summary {
  num? totalEventDues;
  num? totalPenaltyFee;
  num? reactivationAmount;
  num? grandTotal;

  Summary({this.totalEventDues, this.totalPenaltyFee, this.reactivationAmount, this.grandTotal});

  Summary.fromJson(Map<String, dynamic> json) {
    totalEventDues = json['totalEventDues'];
    totalPenaltyFee = json['totalPenaltyFee'];
    reactivationAmount = json['reactivationAmount'];
    grandTotal = json['grandTotal'];
  }
}
