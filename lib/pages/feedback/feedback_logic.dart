import 'dart:typed_data';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FeedbackLogic extends GetxController {

  String content = '';
  Uint8List? image;

  void imageSelected() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(imageQuality: 90,maxWidth: 1024,source: ImageSource.gallery);
      if (pickedFile != null) {
        final imageBytes = await pickedFile.readAsBytes();
        image = imageBytes;
        update();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Please check album permissions or select a new image');
      return;
    }
  }

  void commit() {
    if (content.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter content');
      return;
    }
    if (image == null) {
      Fluttertoast.showToast(msg: 'Please select image');
      return;
    }
    Fluttertoast.showToast(msg: 'Commit success');
    Get.back();
  }

}
