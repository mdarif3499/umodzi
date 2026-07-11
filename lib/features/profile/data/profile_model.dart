class ProfileModel {
  bool? success;
  String? message;
  int? statusCode;
  ProfileData? data;

  ProfileModel({this.success, this.message, this.statusCode, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }
}
class ProfileData {
  OnlineStatus? onlineStatus;
  List<dynamic>? document;
  String? address;
  String? sId;
  String? name;
  String? role;
  String? email;
  String? countryCode;
  String? image;
  String? status;
  bool? isVerified;
  bool? isDeleted;
  String? stripeCustomerId;
  List<PageAccess>? pageAccess;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? phone;

  ProfileData(
      {this.onlineStatus,
      this.document,
      this.address,
      this.sId,
      this.name,
      this.role,
      this.email,
      this.countryCode,
      this.image,
      this.status,
      this.isVerified,
      this.isDeleted,
      this.stripeCustomerId,
      this.pageAccess,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.phone});

  ProfileData.fromJson(Map<String, dynamic> json) {
    onlineStatus = json['onlineStatus'] != null
        ? OnlineStatus.fromJson(json['onlineStatus'])
        : null;
    document = json['document'];
    address = json['address'];
    sId = json['_id'];
    name = json['name'];
    role = json['role'];
    email = json['email'];
    countryCode = json['countryCode'];
    image = json['image'];
    status = json['status'];
    isVerified = json['isVerified'];
    isDeleted = json['isDeleted'];
    stripeCustomerId = json['stripeCustomerId'];
    if (json['pageAccess'] != null) {
      pageAccess = <PageAccess>[];
      json['pageAccess'].forEach((v) {
        pageAccess!.add(PageAccess.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    phone = json['phone'];
  }
}

class OnlineStatus {
  bool? isOnline;
  String? lastSeen;
  String? lastHeartbeat;

  OnlineStatus({this.isOnline, this.lastSeen, this.lastHeartbeat});

  OnlineStatus.fromJson(Map<String, dynamic> json) {
    isOnline = json['isOnline'];
    lastSeen = json['lastSeen'];
    lastHeartbeat = json['lastHeartbeat'];
  }
}

class PageAccess {
  String? name;
  bool? access;
  String? sId;

  PageAccess({this.name, this.access, this.sId});

  PageAccess.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    access = json['access'];
    sId = json['_id'];
  }
}
