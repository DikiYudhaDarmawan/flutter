import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ujikom_flutter/app/utils/api.dart';
import 'package:ujikom_flutter/app/modules/dashboard/views/dashboard_view.dart';

class LoginController extends GetxController {
  final _getConnect = GetConnect();
  final authToken = GetStorage();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void loginNow() async {
    try {
      final response = await _getConnect.post(
        BaseUrl.login,
        {
          'email': emailController.text,
          'password': passwordController.text,
        },
        contentType: "application/json",
      );

      if (response.statusCode == 200) {
        final body = response.body;
        String? token = body['access_token'];
        int? siswaId = body['siswa_id'];

        if (token != null) {
          // Simpan token dan siswa_id
          authToken.write('token', token);
          authToken.write('siswa_id', siswaId);

          print(" Login berhasil! Token: $token | Siswa ID: $siswaId");

          // Arahkan ke Dashboard setelah login berhasil
          Get.offAll(() => const DashboardView());
        } else {
          Get.snackbar("Error", "Token tidak ditemukan dalam respons");
        }
      } else {
        Get.snackbar(
          "Error",
          response.body['message']?.toString() ?? "Login gagal",
          icon: const Icon(Icons.error),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    }
  }
}
