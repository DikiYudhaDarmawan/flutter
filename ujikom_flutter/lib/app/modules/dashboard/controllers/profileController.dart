import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ujikom_flutter/app/data/ProfileResponse.dart';
import 'package:ujikom_flutter/app/utils/api.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var profile = Rxn<User>();
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading(true);

      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        print("❌ Token tidak ditemukan!");
        Get.snackbar("Error", "Token tidak ditemukan. Silakan login ulang.");
        return;
      }

      final response = await http.get(
        Uri.parse(BaseUrl.profile),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print("📡 Response Status: ${response.statusCode}");
      print("📡 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse.containsKey('success') &&
            jsonResponse.containsKey('user')) {
          final data = ProfileResponse.fromJson(jsonResponse);
          profile.value = data.user;
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
}
