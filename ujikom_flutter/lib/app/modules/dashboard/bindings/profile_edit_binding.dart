import 'package:get/get.dart';
import 'package:ujikom_flutter/app/modules/dashboard/controllers/profile_edit_Controller.dart';

class ProfileEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileEditController>(() => ProfileEditController());
  }
}
