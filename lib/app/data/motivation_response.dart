class MotivationResponse {
  bool? success;
  String? message;
  List<Motivation>? motivation;

  MotivationResponse({this.success, this.message, this.motivation});

  MotivationResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      motivation = <Motivation>[];
      json['data'].forEach((v) {
        motivation!.add(new Motivation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.motivation != null) {
      data['data'] = this.motivation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Motivation {
  int? id;
  String? judul;
  String? deskripsi;
  String? image;

  Motivation({this.id, this.judul, this.deskripsi, this.image});

  Motivation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['judul'] = this.judul;
    data['deskripsi'] = this.deskripsi;
    data['image'] = this.image;
    return data;
  }
}
