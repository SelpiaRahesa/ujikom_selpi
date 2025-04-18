class ProfileResponse {
  int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  String? role;
  String? createdAt;
  String? updatedAt;

  ProfileResponse(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.role,
      this.createdAt,
      this.updatedAt});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
