import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pixel_photo/db_pixel/db_pixel.dart';

import '../../db_pixel/pixel_entity.dart';

class PixelMainLogic extends GetxController {

  DBPixel dbPixel = Get.find();

  bool isEdit = false;

  var list = <PixelEntity>[].obs;

  List<PixelEntity> selectedList = [];

  void getData() async {
    list.value = await dbPixel.getPixelAllData();
  }

  void deleteSelected() async {
    if (selectedList.isEmpty) {
      Fluttertoast.showToast(msg: 'Please select at least one item');
      return;
    }
    Get.dialog(AlertDialog(
      title: const Text('Delete or not',textAlign: TextAlign.center,),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel',style: TextStyle(color: Colors.black45),),
        ),
        TextButton(
          onPressed: () async {
            await dbPixel.deletePixels(selectedList);
            selectedList.clear();
            isEdit = false;
            update();
            getData();
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }


}
