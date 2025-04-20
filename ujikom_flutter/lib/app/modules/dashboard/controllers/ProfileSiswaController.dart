import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ujikom_flutter/app/data/ProfileSiswaResponse.dart';
import 'package:ujikom_flutter/app/modules/dashboard/bindings/profile_edit_binding.dart';
import 'package:ujikom_flutter/app/modules/dashboard/views/profile_edit_View.dart';
import 'package:ujikom_flutter/app/utils/api.dart';

class ProfileSiswaController extends GetxController {
  final isLoading = true.obs;
  final profile = Rxn<ProfileSiswa>();
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }
  @override
  void onReady() {
    super.onReady();
    fetchProfile(); 
  }

  Future<void> fetchProfile() async {
    try {
      isLoading(true);
      String? token = box.read('token');

      if (token == null || token.isEmpty) {
        Get.snackbar("Error", "Token tidak ditemukan. Silakan login ulang.");
        Get.offAllNamed('/login');
        return;
      }

      final response = await http.get(
        Uri.parse(BaseUrl.profileSiswa),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print("📡 Response Status: ${response.statusCode}");
      print("📡 Response Body: ${response.body}");
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse.containsKey('status') &&
            jsonResponse.containsKey('data')) {
          final data = ProfileSiswaResponse.fromJson(jsonResponse);
          profile.value = data.data;
        } else {
          print(" Format response tidak sesuai!");
          Get.snackbar("Error", "Format response tidak sesuai");
        }
      } else {
        print("Gagal mendapatkan profil: ${response.body}");
        Get.snackbar("Error", "Gagal mendapatkan profil: ${response.body}");
      }
    } catch (e) {
      print(" Exception: $e");
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> goToEditProfile() async {
    final currentProfile = profile.value;

    if (currentProfile != null && currentProfile.user != null) {
      final result = await Get.to(
        () => ProfileEditView(),
        binding: ProfileEditBinding(),
        arguments: {
          'user_id': currentProfile.user!.id,
          'name': currentProfile.user!.name ?? '',
          'email': currentProfile.user!.email ?? '',
          'phone': currentProfile.nomorTelp ?? '',
        },
      );

      if (result == 'updated') {
        await fetchProfile();
      }
    } else {
      Get.snackbar(
        "Error",
        "Data profil belum tersedia atau belum lengkap.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
