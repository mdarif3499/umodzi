class FamilyMemberModel {
  final String? id;
  final String? userId;
  final String name;
  final String phone;
  final String? countryCode;
  final String relationship;
  final String? address;
  final String? image;
  final List<String>? document;
  final String? status;
  final bool? isVerified;

  FamilyMemberModel({
    this.id,
    this.userId,
    required this.name,
    required this.phone,
    this.countryCode,
    required this.relationship,
    this.address,
    this.image,
    this.document,
    this.status,
    this.isVerified,
  });

  factory FamilyMemberModel.fromJson(Map<String, dynamic> json) {
    return FamilyMemberModel(
      id: json['_id'],
      userId: json['userId'],
      name: json['name'] ?? '',
      phone: json['phoneNumber'] ?? '',
      countryCode: json['countryCode'],
      relationship: json['relationship'] ?? '',
      address: json['address'],
      image: json['image'],
      document: json['document'] != null ? List<String>.from(json['document']) : null,
      status: json['status'],
      isVerified: json['isVerified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'name': name,
      'phoneNumber': phone,
      'countryCode': countryCode,
      'relationship': relationship,
      'address': address,
      'image': image,
      'document': document,
      'status': status,
      'isVerified': isVerified,
    };
  }
}
