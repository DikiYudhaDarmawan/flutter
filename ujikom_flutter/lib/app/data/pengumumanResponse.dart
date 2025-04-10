class PengumumanResponse {
  bool? success;
  String? message;
  List<PengumumanData>? data;

  PengumumanResponse({this.success, this.message, this.data});

  PengumumanResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PengumumanData>[];
      json['data'].forEach((v) {
        data!.add(PengumumanData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PengumumanData {
  int? id;
  int? ekskulId;
  String? judul;
  String? description;
  String? foto;
  String? createdAt;
  String? updatedAt;

  PengumumanData({
    this.id,
    this.ekskulId,
    this.judul,
    this.description,
    this.foto,
    this.createdAt,
    this.updatedAt,
  });

  PengumumanData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ekskulId = json['ekskul_id'];
    judul = json['judul'];
    description = json['description'];
    foto = json['foto'] ?? ""; // Pastikan tidak null
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ekskul_id'] = ekskulId;
    data['judul'] = judul;
    data['description'] = description;
    data['foto'] = foto;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
