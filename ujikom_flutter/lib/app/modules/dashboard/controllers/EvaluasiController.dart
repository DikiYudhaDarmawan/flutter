import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ujikom_flutter/app/data/EvaluasiResponse.dart';
import 'dart:convert';
import 'package:ujikom_flutter/app/utils/api.dart';

class EvaluasiController extends GetxController {
  var isLoading = true.obs;
  var evaluasiList = <Evaluasi>[].obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    int? ekskulId = Get.arguments?['ekskul_id'];
    if (ekskulId != null) {
      fetchEvaluasi(ekskulId);
    } else {
      Get.snackbar("Error", "Ekskul ID tidak ditemukan");
    }
  }

  Future<void> fetchEvaluasi(int ekskulId) async {
    try {
      isLoading(true);
      String token = box.read("token") ?? "";
      var response = await http.get(
        Uri.parse("${BaseUrl.evaluasi}?ekskul_id=$ekskulId"), // Kirim ekskul_id
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var evaluasiResponse = EvaluasiResponse.fromJson(data);

        if (evaluasiResponse.success == true) {
          evaluasiList.value = evaluasiResponse.data ?? [];
        } else {
          evaluasiList.clear();
        }
      } else {
        evaluasiList.clear();
      }
    } catch (e) {
      print("Error fetching evaluasi: $e");
    } finally {
      isLoading(false);
    }
  }
}
