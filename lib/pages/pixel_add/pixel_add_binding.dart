import 'package:get/get.dart';

import 'pixel_add_logic.dart';

class PixelAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PixelAddLogic());
  }
}
