class WalletSummaryModel {
  bool? success;
  String? message;
  int? statusCode;
  WalletSummaryData? data;

  WalletSummaryModel({this.success, this.message, this.statusCode, this.data});

  WalletSummaryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? WalletSummaryData.fromJson(json['data']) : null;
  }
}

class WalletSummaryData {
  String? status;
  double? pendingAmount;
  DateTime? nextDueDate;
  LastPayment? lastPayment;
  SuspensionInfo? suspensionInfo;
  String? activeWarning;

  WalletSummaryData(
      {this.status,
      this.pendingAmount,
      this.nextDueDate,
      this.lastPayment,
      this.suspensionInfo,
      this.activeWarning});

  WalletSummaryData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    pendingAmount = json['pendingAmount']?.toDouble();
    nextDueDate = json['nextDueDate'] != null
        ? DateTime.parse(json['nextDueDate'])
        : null;
    lastPayment = json['lastPayment'] != null
        ? LastPayment.fromJson(json['lastPayment'])
        : null;
    suspensionInfo = json['suspensionInfo'] != null
        ? SuspensionInfo.fromJson(json['suspensionInfo'])
        : null;
    activeWarning = json['activeWarning'];
  }
}

class LastPayment {
  double? amount;
  DateTime? date;

  LastPayment({this.amount, this.date});

  LastPayment.fromJson(Map<String, dynamic> json) {
    amount = json['amount']?.toDouble();
    date = json['date'] != null ? DateTime.parse(json['date']) : null;
  }
}

class SuspensionInfo {
  String? reason;
  String? reactivation;

  SuspensionInfo({this.reason, this.reactivation});

  SuspensionInfo.fromJson(Map<String, dynamic> json) {
    reason = json['reason'];
    reactivation = json['reactivation'];
  }
}
