import 'package:get/get.dart';

import '../controllers/secure_storage_controller.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SecureStorageController());
  }
}
