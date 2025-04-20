import 'package:ujikom_flutter/app/data/YourEkskulResponse.dart';

class ProfileSiswaResponse {
  bool? status;
  String? message;
  ProfileSiswa? data;

  ProfileSiswaResponse({this.status, this.message, this.data});

  ProfileSiswaResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ProfileSiswa.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> responseData = <String, dynamic>{};
    responseData['status'] = this.status;
    responseData['message'] = this.message;
    if (this.data != null) {
      responseData['data'] = this.data!.toJson();
    }
    return responseData;
  }
}

class ProfileSiswa {
  int? id;
  int? idUser;
  String? jenisKelamin;
  int? kelasId;
  int? jurusanId;
  int? gelombangBelajarId;
  String? nomorTelp;
  String? createdAt;
  String? updatedAt;
  User? user;
  Kelas? kelas;
  Jurusan? jurusan;
  GelombangBelajar? gelombangBelajar;
  // Jika diperlukan, data siswa_ekskuls juga bisa ditambahkan

  ProfileSiswa({
    this.id,
    this.idUser,
    this.jenisKelamin,
    this.kelasId,
    this.jurusanId,
    this.gelombangBelajarId,
    this.nomorTelp,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.kelas,
    this.jurusan,
    this.gelombangBelajar,
  });

  ProfileSiswa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    jenisKelamin = json['jenis_kelamin'];
    kelasId = json['kelas_id'];
    jurusanId = json['jurusan_id'];
    gelombangBelajarId = json['gelombang_belajar_id'];
    nomorTelp = json['nomor_telp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    kelas = json['kelas'] != null ? Kelas.fromJson(json['kelas']) : null;
    jurusan =
        json['jurusan'] != null ? Jurusan.fromJson(json['jurusan']) : null;
    gelombangBelajar = json['gelombang_belajar'] != null
        ? GelombangBelajar.fromJson(json['gelombang_belajar'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['id'] = this.id;
    dataMap['id_user'] = this.idUser;
    dataMap['jenis_kelamin'] = this.jenisKelamin;
    dataMap['kelas_id'] = this.kelasId;
    dataMap['jurusan_id'] = this.jurusanId;
    dataMap['gelombang_belajar_id'] = this.gelombangBelajarId;
    dataMap['nomor_telp'] = this.nomorTelp;
    dataMap['created_at'] = this.createdAt;
    dataMap['updated_at'] = this.updatedAt;
    if (this.user != null) {
      dataMap['user'] = this.user!.toJson();
    }
    if (this.kelas != null) {
      dataMap['kelas'] = this.kelas!.toJson();
    }
    if (this.jurusan != null) {
      dataMap['jurusan'] = this.jurusan!.toJson();
    }
    if (this.gelombangBelajar != null) {
      dataMap['gelombang_belajar'] = this.gelombangBelajar!.toJson();
    }
    return dataMap;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? foto; // Pastikan disini ada field foto untuk user
  String? role;
  int? status;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.foto,
    this.role,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    foto = json['foto']; // Jika API menyediakannya
    role = json['role'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> userData = <String, dynamic>{};
    userData['id'] = this.id;
    userData['name'] = this.name;
    userData['email'] = this.email;
    userData['foto'] = this.foto;
    userData['role'] = this.role;
    userData['status'] = this.status;
    userData['created_at'] = this.createdAt;
    userData['updated_at'] = this.updatedAt;
    return userData;
  }
}

class Kelas {
  int? id;
  int? tingkat;

  Kelas({this.id, this.tingkat});

  Kelas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tingkat = json['tingkat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> kelasData = <String, dynamic>{};
    kelasData['id'] = this.id;
    kelasData['tingkat'] = this.tingkat;
    return kelasData;
  }
}

class Jurusan {
  int? id;
  String? nama;

  Jurusan({this.id, this.nama});

  Jurusan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jurusanData = <String, dynamic>{};
    jurusanData['id'] = this.id;
    jurusanData['nama'] = this.nama;
    return jurusanData;
  }
}

class GelombangBelajar {
  int? id;
  int? gelombang;

  GelombangBelajar({this.id, this.gelombang});

  GelombangBelajar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gelombang = json['gelombang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> gbData = <String, dynamic>{};
    gbData['id'] = this.id;
    gbData['gelombang'] = this.gelombang;
    return gbData;
  }
}

class SiswaEkskuls {
  int? id;
  int? siswaId;
  int? ekskulId;
  String? joinedAt;
  String? createdAt;
  String? updatedAt;
  Ekskul? ekskul;

  SiswaEkskuls(
      {this.id,
      this.siswaId,
      this.ekskulId,
      this.joinedAt,
      this.createdAt,
      this.updatedAt,
      this.ekskul});

  SiswaEkskuls.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siswaId = json['siswa_id'];
    ekskulId = json['ekskul_id'];
    joinedAt = json['joined_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ekskul = json['ekskul'] != null ? Ekskul.fromJson(json['ekskul']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> siswaEksData = <String, dynamic>{};
    siswaEksData['id'] = this.id;
    siswaEksData['siswa_id'] = this.siswaId;
    siswaEksData['ekskul_id'] = this.ekskulId;
    siswaEksData['joined_at'] = this.joinedAt;
    siswaEksData['created_at'] = this.createdAt;
    siswaEksData['updated_at'] = this.updatedAt;
    if (this.ekskul != null) {
      siswaEksData['ekskul'] = this.ekskul!.toJson();
    }
    return siswaEksData;
  }
}
