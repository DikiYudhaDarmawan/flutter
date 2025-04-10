class YourEkskulResponse {
  String? status;
  int? siswaId;
  List<YourEkskul>? data;

  YourEkskulResponse({this.status, this.siswaId, this.data});

  YourEkskulResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    siswaId = json['siswa_id'];
    if (json['data'] != null) {
      data = <YourEkskul>[];
      json['data'].forEach((v) {
        data!.add(YourEkskul.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'siswa_id': siswaId,
      'data': data?.map((v) => v.toJson()).toList(),
    };
  }
}

class YourEkskul {
  int? id;
  int? siswaId;
  int? ekskulId;
  String? joinedAt;
  String? createdAt;
  String? updatedAt;
  Ekskul? ekskul;

  YourEkskul(
      {this.id,
      this.siswaId,
      this.ekskulId,
      this.joinedAt,
      this.createdAt,
      this.updatedAt,
      this.ekskul});

  YourEkskul.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siswaId = json['siswa_id'];
    ekskulId = json['ekskul_id'];
    joinedAt = json['joined_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ekskul = json['ekskul'] != null ? Ekskul.fromJson(json['ekskul']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'siswa_id': siswaId,
      'ekskul_id': ekskulId,
      'joined_at': joinedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'ekskul': ekskul?.toJson(),
    };
  }
}

class Ekskul {
  int? id;
  String? foto;
  String? name;
  String? description;
  int? pembinaId;
  String? activityDate;
  String? startTime;
  String? endTime;
  String? location;
  String? createdAt;
  String? updatedAt;

  Ekskul(
      {this.id,
      this.foto,
      this.name,
      this.description,
      this.pembinaId,
      this.activityDate,
      this.startTime,
      this.endTime,
      this.location,
      this.createdAt,
      this.updatedAt});

  Ekskul.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foto = json['foto'];
    name = json['name'];
    description = json['description'];
    pembinaId = json['pembina_id'];
    activityDate = json['activity_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'foto': foto,
      'name': name,
      'description': description,
      'pembina_id': pembinaId,
      'activity_date': activityDate,
      'start_time': startTime,
      'end_time': endTime,
      'location': location,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
