import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ujikom_flutter/app/data/pengumumanResponse.dart';
import 'package:ujikom_flutter/app/utils/api.dart';

class PengumumanController extends GetxController {
  var isLoading = true.obs;
  var pengumumanList = <PengumumanData>[].obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    int? ekskulId = Get.arguments?['ekskul_id'];
    if (ekskulId != null) {
      fetchPengumuman(ekskulId);
    } else {
      Get.snackbar("Error", "Ekskul ID tidak ditemukan");
    }
  }

  Future<void> fetchPengumuman(int ekskulId) async {
    try {
      isLoading(true);
      String? token = box.read('token');

      if (token == null) {
        Get.snackbar("Error", "Token tidak ditemukan, silakan login ulang.");
        Get.offAllNamed('/login'); // Redirect ke login jika token tidak ada
        return;
      }

      print("Fetching pengumuman for ekskul_id: $ekskulId");
      final response = await http.get(
        Uri.parse("${BaseUrl.pengumuman}/$ekskulId"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var data = PengumumanResponse.fromJson(jsonResponse);

        print("Parsed Data: ${data.data}");

        pengumumanList.assignAll(data.data ?? []);
      } else if (response.statusCode == 401) {
        box.remove('token');
        Get.snackbar("Sesi Habis", "Silakan login ulang.");
        Get.offAllNamed('/login');
      } else {
        var errorResponse = json.decode(response.body);
        Get.snackbar("Error",
            errorResponse["message"] ?? "Gagal mengambil data pengumuman");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }
}
