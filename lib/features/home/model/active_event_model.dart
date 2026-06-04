class ActiveEventModel {
  final bool? success;
  final String? message;
  final int? statusCode;
  final List<ActiveEvent>? data;
  final Meta? meta;

  ActiveEventModel({
    this.success,
    this.message,
    this.statusCode,
    this.data,
    this.meta,
  });

  factory ActiveEventModel.fromJson(Map<String, dynamic> json) => ActiveEventModel(
    success: json["success"],
    message: json["message"],
    statusCode: json["statusCode"],
    data: json["data"] == null ? [] : List<ActiveEvent>.from(json["data"].map((x) => ActiveEvent.fromJson(x))),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );
}

class ActiveEvent {
  final String? id;
  final String? createBy;
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

  ActiveEvent({
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

  factory ActiveEvent.fromJson(Map<String, dynamic> json) => ActiveEvent(
    id: json["_id"],
    createBy: json["createBy"],
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
