import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ujikom_flutter/app/data/EkskulResponse.dart';
import 'package:ujikom_flutter/app/modules/dashboard/controllers/ProfileSiswaController.dart';
import 'package:ujikom_flutter/app/modules/dashboard/views/ProfileSiswaView.dart'; // <-- disesuaikan lowercase
import 'package:ujikom_flutter/app/utils/api.dart';
import '../views/index_view.dart';
import '../views/your_ekskul_view.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;
  var isLoading = true.obs;
  var ekskuls = <Ekskuls>[].obs;
  final _getConnect = GetConnect();
  final box = GetStorage();

  final List<Widget> pages = [
    const IndexView(),
    const YourEkskulView(),
    const ProfileSiswaView(),
  ];

  @override
  void onInit() {
    super.onInit();
    loadEkskuls();

  }

  Future<void> loadEkskuls() async {
    try {
      isLoading(true);
      final response = await _getConnect.get(
        BaseUrl.ekskuls,
        headers: {'Authorization': "Bearer ${box.read('token')}"},
        contentType: "application/json",
      );
      if (response.statusCode == 200) {
        final result = EkskulResponse.fromJson(response.body);
        if (result.ekskuls != null) {
          ekskuls.assignAll(result.ekskuls!);
        }
      } else {
        Get.snackbar("Error", "Status code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

void changeIndex(int index) {
      selectedIndex.value = index;
    }
  

  Future<void> logOut() async {
    try {
      final response = await _getConnect.post(
        BaseUrl.logout,
        {},
        headers: {'Authorization': "Bearer ${box.read('token')}"},
        contentType: "application/json",
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Logout Berhasil!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Hapus data lokal
        await box.erase();

        // Hapus controller profil agar tidak menyimpan data user sebelumnya
        if (Get.isRegistered<ProfileSiswaController>()) {
          Get.delete<ProfileSiswaController>();
        }

        // Redirect ke login
        Get.offAllNamed('/login');
      } else {
        Get.snackbar(
          'Failed',
          'Logout Gagal',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
