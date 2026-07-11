class FaqModel {
  bool? success;
  String? message;
  int? statusCode;
  List<FaqData>? data;

  FaqModel({this.success, this.message, this.statusCode, this.data});
  FaqModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <FaqData>[];
      json['data'].forEach((v) {
        data!.add(FaqData.fromJson(v));
      });
    }
  }
}
class FaqData {
  String? sId;
  String? question;
  String? answer;
  String? createdAt;
  String? updatedAt;
  int? iV;

  FaqData(
      {this.sId,
      this.question,
      this.answer,
      this.createdAt,
      this.updatedAt,
      this.iV});

  FaqData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    question = json['question'];
    answer = json['answer'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
