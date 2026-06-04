class PaymentSummaryModel {
  bool? success;
  String? message;
  int? statusCode;
  PaymentSummaryData? data;

  PaymentSummaryModel({this.success, this.message, this.statusCode, this.data});

  PaymentSummaryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? PaymentSummaryData.fromJson(json['data']) : null;
  }
}

class PaymentSummaryData {
  double? totalPaid;
  double? pendingAmount;
  double? penaltyAmount;
  String? penaltyNotice;

  PaymentSummaryData(
      {this.totalPaid,
      this.pendingAmount,
      this.penaltyAmount,
      this.penaltyNotice});

  PaymentSummaryData.fromJson(Map<String, dynamic> json) {
    totalPaid = json['totalPaid']?.toDouble();
    pendingAmount = json['pendingAmount']?.toDouble();
    penaltyAmount = json['penaltyAmount']?.toDouble();
    penaltyNotice = json['penaltyNotice'];
  }
}
