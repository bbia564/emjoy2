import 'package:get/get.dart';

import 'pixel_setting_logic.dart';

class PixelSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PixelSettingLogic());
  }
}
