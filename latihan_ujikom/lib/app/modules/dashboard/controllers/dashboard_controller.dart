import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latihan_ujikom/app/data/detail_event_response.dart';
import 'package:latihan_ujikom/app/data/event_response.dart';
import 'package:latihan_ujikom/app/modules/dashboard/views/index_view.dart';
import 'package:latihan_ujikom/app/modules/dashboard/views/your_event_view.dart';
import 'package:latihan_ujikom/app/modules/profile/views/profile_view.dart';
import 'package:latihan_ujikom/app/utils/api.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;
  final _getConnect = GetConnect();

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [
    IndexView(),
    YourEventView(),
    ProfileView(),
  ];

  @override
  void onInit() {
    getEvent();
    getYourEvent();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  final token = GetStorage().read('token');

  Future<EventResponse> getEvent() async {
    final response = await _getConnect.get(
      BaseUrl.events,
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );
    return EventResponse.fromJson(response.body);
  }

  var yourEvents = <Events>[].obs;

  Future<void> getYourEvent() async {
    final response = await _getConnect.get(
      BaseUrl.yourEvent,
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );
    final eventResponse = EventResponse.fromJson(response.body);
    yourEvents.value = eventResponse.events ?? [];
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  void addEvent() async {
    final response = await _getConnect.post(
      BaseUrl.events, // URL buat API tambah event
      {
        'name': nameController.text,
        'description': descriptionController.text,
        'event_date': eventDateController.text,
        'location': locationController.text,
      },
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );

    if (response.statusCode == 201) {
      Get.snackbar(
        'Success',
        'Event Added',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      nameController.clear();
      descriptionController.clear();
      eventDateController.clear();
      locationController.clear();
      update();
      getEvent();
      getYourEvent();
      Get.close(1);
    } else {
      Get.snackbar(
        'Failed',
        'Event Failed to Add',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<DetailEventResponse> getDetailEvent({required int id}) async {
    final response = await _getConnect.get(
      '${BaseUrl.detailEvents}/$id',
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );
    return DetailEventResponse.fromJson(response.body);
  }

  void editEvent({required int id}) async {
    final response = await _getConnect.post(
      '${BaseUrl.events}/$id',
      {
        'name': nameController.text,
        'description': descriptionController.text,
        'event_date': eventDateController.text,
        'location': locationController.text,
        '_method': 'PUT',
      },
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );

    if (response.statusCode == 200) {
      Get.snackbar(
        'Success',
        'Event Updated',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      nameController.clear();
      descriptionController.clear();
      eventDateController.clear();
      locationController.clear();

      update();
      getEvent();
      getYourEvent();
      Get.close(1);
    } else {
      Get.snackbar(
        'Failed',
        'Event Failed to Update',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void deleteEvent({required int id}) async {
    final response = await _getConnect.post(
      '${BaseUrl.deleteEvents}/$id',
      {
        '_method': 'delete',
      },
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );

    if (response.statusCode == 200) {
      Get.snackbar(
        'Success',
        'Event Deleted',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      update();
      getEvent();
      getYourEvent();
    } else {
      Get.snackbar(
        'Failed',
        'Event Failed to Delete',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
  // Fungsi buat logout user
  void logOut() async {
    // Kirim request POST ke server buat logout
    final response = await _getConnect.post(
      BaseUrl.logout, // Endpoint buat logout
      {}, // Gak ada body karena logout aja
      headers: {'Authorization': "Bearer $token"}, // Header dengan token user
      contentType: "application/json", // Format data JSON
    );

    // Kalau server bilang logout sukses
    if (response.statusCode == 200) {
      // Kasih notifikasi logout berhasil
      Get.snackbar(
        'Success', // Judul snack bar
        'Logout Success', // Pesan sukses
        snackPosition: SnackPosition.BOTTOM, // Snack muncul di bawah
        backgroundColor: Colors.green, // Warna hijau biar good vibes
        colorText: Colors.white, // Teks putih biar jelas
      );

      // Hapus semua data user dari penyimpanan lokal
      GetStorage().erase();

      // Redirect user ke halaman login
      Get.offAllNamed('/login'); // Bersih-bersih dan langsung ke login
    } else {
      // Kalau gagal logout, kasih tau user
      Get.snackbar(
        'Failed', // Judul snack bar
        'Logout Failed', // Pesan error
        snackPosition: SnackPosition.BOTTOM, // Snack muncul di bawah
        backgroundColor: Colors.red, // Warna merah buat error vibes
        colorText: Colors.white, // Teks putih biar kontras
      );
    }
  }
}