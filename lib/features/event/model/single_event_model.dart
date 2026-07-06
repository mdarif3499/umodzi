class SingleEventModel {
  final bool? success;
  final String? message;
  final int? statusCode;
  final SingleEventData? data;
  SingleEventModel({
    this.success,
    this.message,
    this.statusCode,
    this.data,
  });
  factory SingleEventModel.fromJson(Map<String, dynamic> json) => SingleEventModel(
    success: json["success"],
    message: json["message"],
    statusCode: json["statusCode"],
    data: json["data"] == null ? null : SingleEventData.fromJson(json["data"]),
  );
}
class SingleEventData {
  final Event? event;
  final UserStats? users;

  SingleEventData({
    this.event,
    this.users,
  });
  factory SingleEventData.fromJson(Map<String, dynamic> json) => SingleEventData(
    event: json["event"] == null ? null : Event.fromJson(json["event"]),
    users: json["users"] == null ? null : UserStats.fromJson(json["users"]),
  );
}
class Event {
  final String? id;
  final CreateBy? createBy;
  final String? name;
  final String? eventType;
  final String? eventTypeId;
  final String? banner;
  final String? description;
  final double? minContribution;
  final double? targetContribution;
  final DateTime? eventDeadline;
  final Beneficiary? beneficiary;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  Event({
    this.id,
    this.createBy,
    this.name,
    this.eventType,
    this.eventTypeId,
    this.banner,
    this.description,
    this.minContribution,
    this.targetContribution,
    this.eventDeadline,
    this.beneficiary,
    this.status,
    this.createdAt,
    this.updatedAt,
  });
  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json["_id"],
    createBy: json["createBy"] == null ? null : CreateBy.fromJson(json["createBy"]),
    name: json["name"],
    eventType: json["eventType"],
    eventTypeId: json["eventTypeId"],
    banner: json["banner"],
    description: json["description"],
    minContribution: json["minContribution"]?.toDouble(),
    targetContribution: json["targetContribution"]?.toDouble(),
    eventDeadline: json["eventDeadline"] == null ? null : DateTime.parse(json["eventDeadline"]),
    beneficiary: json["beneficiary"] == null ? null : Beneficiary.fromJson(json["beneficiary"]),
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );
}
class Beneficiary {
  final String? userId;
  final String? email;
  final String? name;
  final String? relationship;
  final String? contactNumber;
  final String? countryCode;
  final String? address;
  final String? image;
  final List<String>? documents;
  final String? fundsReason;
  Beneficiary({
    this.userId,
    this.email,
    this.name,
    this.relationship,
    this.contactNumber,
    this.countryCode,
    this.address,
    this.image,
    this.documents,
    this.fundsReason,
  });
  factory Beneficiary.fromJson(Map<String, dynamic> json) => Beneficiary(
    userId: json["userId"],
    email: json["email"],
    name: json["name"],
    relationship: json["relationship"],
    contactNumber: json["contactNumber"],
    countryCode: json["countryCode"],
    address: json["address"],
    image: json["image"],
    documents: json["documents"] == null ? [] : List<String>.from(json["documents"].map((x) => x)),
    fundsReason: json["fundsReason"],
  );
}
class CreateBy {
  final String? id;
  final String? name;
  final String? role;
  final String? email;
  final String? image;
  CreateBy({
    this.id,
    this.name,
    this.role,
    this.email,
    this.image,
  });
  factory CreateBy.fromJson(Map<String, dynamic> json) => CreateBy(
    id: json["_id"],
    name: json["name"],
    role: json["role"],
    email: json["email"],
    image: json["image"],
  );
}
class UserStats {
  final int? totalPaidUsers;
  final int? totalUsers;
  final double? totalPercentage;
  UserStats({
    this.totalPaidUsers,
    this.totalUsers,
    this.totalPercentage,
  });
  factory UserStats.fromJson(Map<String, dynamic> json) => UserStats(
    totalPaidUsers: json["totalPaidUsers"],
    totalUsers: json["totalUsers"],
    totalPercentage: json["totalPercentage"]?.toDouble(),
  );
}
