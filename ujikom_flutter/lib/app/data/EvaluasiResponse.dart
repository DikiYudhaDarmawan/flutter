class EvaluasiResponse {
  bool? success;
  String? message;
  List<Evaluasi>? data;

  EvaluasiResponse({this.success, this.message, this.data});

  EvaluasiResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Evaluasi>[];
      json['data'].forEach((v) {
        data!.add(new Evaluasi.fromJson(v));
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

class Evaluasi {
  int? id;
  int? siswaId;
  int? pembinaId;
  int? ekskulId;
  String? grade;
  String? description;
  String? createdAt;
  String? updatedAt;
  Pembina? pembina;
  Pembina? ekskul;

  Evaluasi(
      {this.id,
      this.siswaId,
      this.pembinaId,
      this.ekskulId,
      this.grade,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.pembina,
      this.ekskul});

  Evaluasi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siswaId = json['siswa_id'];
    pembinaId = json['pembina_id'];
    ekskulId = json['ekskul_id'];
    grade = json['grade'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pembina =
        json['pembina'] != null ? new Pembina.fromJson(json['pembina']) : null;
    ekskul =
        json['ekskul'] != null ? new Pembina.fromJson(json['ekskul']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['siswa_id'] = this.siswaId;
    data['pembina_id'] = this.pembinaId;
    data['ekskul_id'] = this.ekskulId;
    data['grade'] = this.grade;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pembina != null) {
      data['pembina'] = this.pembina!.toJson();
    }
    if (this.ekskul != null) {
      data['ekskul'] = this.ekskul!.toJson();
    }
    return data;
  }
}

class Pembina {
  int? id;
  String? name;

  Pembina({this.id, this.name});

  Pembina.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
