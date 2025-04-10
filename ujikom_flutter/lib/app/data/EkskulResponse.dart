class EkskulResponse {
  bool? success;
  List<Ekskuls>? ekskuls;

  EkskulResponse({this.success, this.ekskuls});

  // Perhatikan: API mengembalikan data di key "data"
  EkskulResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      ekskuls = <Ekskuls>[];
      json['data'].forEach((v) {
        ekskuls!.add(Ekskuls.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (ekskuls != null) {
      data['data'] = ekskuls!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ekskuls {
  int? id;
  String? foto;
  String? name;
  String? description;
  int? pembinaId;
  String? activityDate;
  String? startTime;
  String? endTime;
  String? activityDate2;
  String? startTime2;
  String? endTime2;
  String? location;
  String? createdAt;
  String? updatedAt;
  bool? isRegistered;

  Ekskuls({
    this.id,
    this.foto,
    this.name,
    this.description,
    this.pembinaId,
    this.activityDate,
    this.startTime,
    this.endTime,
    this.activityDate2,
    this.startTime2,
    this.endTime2,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.isRegistered,
  });

  Ekskuls.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foto = json['foto'];
    name = json['name'];
    description = json['description'];
    pembinaId = json['pembina_id'];
    activityDate = json['activity_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    activityDate2 = json['activity_date2'];
    startTime2 = json['start_time2'];
    endTime2 = json['end_time2'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isRegistered = json['is_registered'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['foto'] = foto;
    data['name'] = name;
    data['description'] = description;
    data['pembina_id'] = pembinaId;
    data['activity_date'] = activityDate;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['activity_date2'] = activityDate2;
    data['start_time2'] = startTime2;
    data['end_time2'] = endTime2;
    data['location'] = location;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
       data['is_registered'] = isRegistered;
    return data;
  }
}
