import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ujikom_flutter/app/utils/api.dart';

class ProfileEditController extends GetxController {
  final box = GetStorage();
  final _getConnect = GetConnect();

  var isLoading = false.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchCurrentProfile();
  }

  void fetchCurrentProfile() {
    final args = Get.arguments ?? {};

    if (args.isNotEmpty) {
      nameController.text = args['name'] ?? '';
      emailController.text = args['email'] ?? '';
      phoneController.text = args['phone'] ?? '';
    } else {
      final user = box.read('user');
      if (user != null) {
        nameController.text = user['name'] ?? '';
        emailController.text = user['email'] ?? '';
        phoneController.text = user['nomor_telp'] ?? '';
      } else {
        Get.snackbar(
          'Error',
          'Tidak dapat mengambil data pengguna.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  Future<void> updateProfile() async {
    if (nameController.text.isEmpty || emailController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Nama dan Email tidak boleh kosong',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading(true);

      final response = await _getConnect.post(
        BaseUrl.profileUpdate,
        {
          '_method': 'PUT',
          'name': nameController.text,
          'email': emailController.text,
          'nomor_telp': phoneController.text,
        },
        headers: {'Authorization': "Bearer ${box.read('token')}"},
      );

      if (response.statusCode == 200) {
        Get.defaultDialog(
          title: "Berhasil",
          middleText: "Profil kamu sudah diperbarui.",
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back(); // tutup dialog
            Get.back(result: 'updated'); // kembali ke view profil
          },
        );
      } else if (response.statusCode == 422) {
        final errors = response.body['errors'] ?? {};
        String msg = errors.values.map((e) => e.join(', ')).join('\n');
        Get.snackbar(
          'Validasi Gagal',
          msg,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Gagal',
          'Gagal memperbarui profil. Silakan coba lagi.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }
}
