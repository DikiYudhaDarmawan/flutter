import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ujikom_flutter/app/modules/dashboard/views/dashboard_view.dart';
import 'package:ujikom_flutter/app/utils/api.dart';

class RegisterController extends GetxController {
  final _getConnect = GetConnect();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =TextEditingController();
  TextEditingController jenisKelaminController = TextEditingController();
  TextEditingController kelasIdController = TextEditingController();
  TextEditingController jurusanIdController = TextEditingController();
  TextEditingController gelombangBelajarIdController = TextEditingController();
  TextEditingController nomorTelpController = TextEditingController();

  final authToken = GetStorage();

  void registerNow() async {
    final response = await _getConnect.post(BaseUrl.register, {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'password_confirmation': passwordConfirmationController.text,
      'jenis_kelamin': jenisKelaminController.text,
      'kelas_id': int.tryParse(kelasIdController.text),
      'jurusan_id': int.tryParse(jurusanIdController.text),
      'gelombang_belajar_id': int.tryParse(gelombangBelajarIdController.text),
      'nomor_telp': nomorTelpController.text,
    });

    if (response.statusCode == 201) {
      authToken.write('token', response.body['access_token']);
      Get.offAll(() => const DashboardView());
    } else {
      Get.snackbar(
        'Error',
        response.body.toString(),
        icon: const Icon(Icons.error),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        forwardAnimationCurve: Curves.bounceIn,
        margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
      );
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    jenisKelaminController.dispose();
    kelasIdController.dispose();
    jurusanIdController.dispose();
    gelombangBelajarIdController.dispose();
    nomorTelpController.dispose();
    super.onClose();
  }
}
