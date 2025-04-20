import 'package:get/get.dart';
import 'package:ujikom_flutter/app/modules/dashboard/controllers/ProfileSiswaController.dart';
import 'package:ujikom_flutter/app/modules/dashboard/controllers/dashboard_controller.dart';

class profileSiswaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileSiswaController>(() => ProfileSiswaController());
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
