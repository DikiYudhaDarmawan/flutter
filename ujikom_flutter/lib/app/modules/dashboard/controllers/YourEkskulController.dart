import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ujikom_flutter/app/data/YourEkskulResponse.dart';
import 'package:ujikom_flutter/app/modules/dashboard/views/evaluasiView.dart';
import 'package:ujikom_flutter/app/modules/dashboard/views/pengumumanView.dart';
import 'package:ujikom_flutter/app/utils/api.dart';

class YourEkskulController extends GetxController {
  var isLoading = true.obs;
  var ekskuls = <YourEkskul>[].obs;
  final _getConnect = GetConnect();
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    checkToken();
  }

  void checkToken() {
    String? savedToken = box.read('token');

    if (savedToken == null || savedToken.isEmpty) {
      print("⚠️ Error: Token tidak ditemukan. Pastikan user sudah login.");
      Get.snackbar("Error", "Token tidak ditemukan. Silakan login ulang.");
    } else {
      print("✅ Token tersimpan: $savedToken");
      loadEkskuls(savedToken);
    }
  }

  Future<void> loadEkskuls(String token) async {
    try {
      isLoading(true);
      print("Fetching ekskuls...");
      print("Token: $token");

      final response = await _getConnect.get(
        BaseUrl.yourEkskul,
        headers: {'Authorization': "Bearer $token"},
      );

      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final result = YourEkskulResponse.fromJson(response.body);
        print("Parsed Data: ${result.data}");
        ekskuls.assignAll(result.data ?? []);
      } else {
        print("❌ Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("❌ Error: $e");
    } finally {
      isLoading(false);
    }
  }

  void goToPengumuman(int? ekskulId) {
    if (ekskulId != null) {
      Get.to(() => PengumumanView(), arguments: {"ekskul_id": ekskulId});
    } else {
      Get.snackbar("Error", "Ekskul tidak valid");
    }
  }
  void goToNilai(int? ekskulId) {
  if (ekskulId != null) {
      Get.to(() => EvaluasiView(), arguments: {"ekskul_id": ekskulId});
    } else {
      Get.snackbar("Error", "Ekskul tidak valid");
    }
  }
}
