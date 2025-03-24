import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'pixel_setting_logic.dart';

class PixelSettingPage extends GetView<PixelSettingLogic> {
  Widget _item(int index, BuildContext context) {
    final titles = ['Clean all records', 'Feedback', 'About us'];
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: <Widget>[
        Text(titles[index]),
        index == 2
            ? const Text("1.0.0").paddingOnly(right: 10)
            : const Icon(
                Icons.keyboard_arrow_right,
                size: 20,
                color: Colors.grey,
              )
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    )
        .decorated(
            borderRadius: BorderRadius.circular(4),
            color: const Color(0xfff8f8f8))
        .marginOnly(bottom: 10)
        .gestures(onTap: () {
      switch (index) {
        case 0:
          controller.cleanPixelData();
          break;
        case 1:
          Get.toNamed('/feedback');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Setting"),
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            _item(0, context),
            _item(1, context),
            _item(2, context)
          ].toColumn(),
        ).marginAll(15)),
      ),
    );
  }
}
