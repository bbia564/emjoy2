import 'package:get/get.dart';

import 'pixel_main_logic.dart';

class PixelMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PixelMainLogic());
  }
}
