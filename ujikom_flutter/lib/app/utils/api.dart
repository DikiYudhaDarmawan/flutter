import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class BaseUrl {
  static String login = 'http://192.168.0.76:8000/api/login';
  static String register = 'http://192.168.0.76:8000/api/register';
  static String logout = 'http://192.168.0.76:8000/api/logout';

  static String profile = 'http://192.168.0.76:8000/api/profile';
  static String profileSiswa = 'http://192.168.0.76:8000/api/profilewithsiswa';
  static String  profileUpdate = 'http://192.168.0.76:8000/api/editprofilewithsiswa';
  static String pengumuman = 'http://192.168.0.76:8000/api/pengumuman';
  static String evaluasi = 'http://192.168.0.76:8000/api/evaluasi';
  static String daftarEkskul = 'http://192.168.0.76:8000/api/daftar-ekskul';
  static String ekskuls = 'http://192.168.0.76:8000/api/ekskuls';
  static String yourEkskul = 'http://192.168.0.76:8000/api/siswa/ekskuls';
  static String pengumumannotif ='http://192.168.0.76:8000/api/notifikasi-pengumuman';
}

class Api {
  static Future<void> daftarEkskul(String token, int ekskulId) async {
    try {
      final response = await http.post(
        Uri.parse(BaseUrl.daftarEkskul),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"ekskul_id": ekskulId}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        Get.snackbar(
          "Sukses",
          responseData['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Gagal",
          responseData['message'] ?? 'Terjadi kesalahan saat mendaftar.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Tidak dapat terhubung ke server",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
