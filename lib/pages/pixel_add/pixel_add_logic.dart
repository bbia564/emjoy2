import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pixel_photo/db_pixel/db_pixel.dart';
import 'package:pixel_photo/db_pixel/pixel_entity.dart';
import 'package:pixel_photo/pages/pixel_add/pixel_text_field.dart';
import 'package:styled_widget/styled_widget.dart';

class PixelAddLogic extends GetxController {
  DBPixel dbPixel = Get.find();

  PixelEntity? entity = Get.arguments;

  Uint8List? image;

  int currentIndex = 0;

  List<ColorEntity> currentList = [];

  void initCurrentList() {
    currentList = [];
    for (int i = 0; i < 20 * 20; i++) {
      currentList
          .add(ColorEntity(colorIndex: i, colorCode: const Color(0xfff2f2f2)));
    }
    update();
  }

  void save() {
    var title = entity?.title ?? '';
    Get.dialog(AlertDialog(
      title: const Text(
        'Title of work',
        textAlign: TextAlign.center,
      ),
      content: Container(
        width: double.infinity,
        height: 50,
        child: PixelTextField(
            textAlign: TextAlign.center,
            value: title,
            maxLength: 20,
            onChange: (v) {
              title = v;
            }),
      ).decorated(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xffd3d3d3))),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black45),
          ),
        ),
        TextButton(
          onPressed: () async {
            if (title.isEmpty) {
              Fluttertoast.showToast(msg: 'Please enter title');
              return;
            }
            if (entity == null) {
              entity = PixelEntity(
                id: 0,
                  createdTime: DateTime.now(),
                  title: title,
                  list: currentList,image: image!);
              await dbPixel.insertPixel(entity!);
            } else {
              entity!.title = title;
              entity!.list = currentList;
              entity!.image = image!;
              await dbPixel.updatePixel(entity!);
            }
            Fluttertoast.showToast(msg: 'Saved');
            Get.until((route) => Get.currentRoute == '/pixelMain');
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    if (entity == null) {
      initCurrentList();
    } else {
      currentList = entity!.list;
      update();
    }
    super.onInit();
  }
}
