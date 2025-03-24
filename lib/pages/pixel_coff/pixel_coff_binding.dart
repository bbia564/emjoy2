import 'package:get/get.dart';

import 'pixel_coff_logic.dart';

class PixelCoffBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
