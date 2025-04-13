class PerusahaanResponse {
  bool? success;
  String? message;
  List<Perusahaan>? data;

  PerusahaanResponse({this.success, this.message, this.data});

  PerusahaanResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Perusahaan>[];
      json['data'].forEach((v) {
        data!.add(new Perusahaan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Perusahaan {
  int? id;
  String? namaPerusahaan;
  String? email;
  int? telepon;
  String? alamat;
  String? image;
  String? createdAt;
  String? updatedAt;

  Perusahaan(
      {this.id,
      this.namaPerusahaan,
      this.email,
      this.telepon,
      this.alamat,
      this.image,
      this.createdAt,
      this.updatedAt});

  Perusahaan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaPerusahaan = json['nama_perusahaan'];
    email = json['email'];
    telepon = json['telepon'];
    alamat = json['alamat'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_perusahaan'] = this.namaPerusahaan;
    data['email'] = this.email;
    data['telepon'] = this.telepon;
    data['alamat'] = this.alamat;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
