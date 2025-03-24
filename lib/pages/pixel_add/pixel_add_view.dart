import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pixel_photo/main.dart';
import 'package:styled_widget/styled_widget.dart';
import 'pixel_add_logic.dart';

// class PixelAddPage extends GetView<PixelAddLogic> {
//
// }

class PixelAddPage extends StatefulWidget {
  const PixelAddPage({Key? key}) : super(key: key);

  @override
  State<PixelAddPage> createState() => _PixelAddPageState();
}

class _PixelAddPageState extends State<PixelAddPage> {
  PixelAddLogic controller = Get.find();

  final GlobalKey _repaintKey = GlobalKey();

  Future<void> _captureImage() async {
    try {
      RenderRepaintBoundary boundary = _repaintKey.currentContext!
          .findRenderObject()! as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        controller.image = byteData.buffer.asUint8List();
      }
    } catch (_) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.entity?.title ?? 'Pixel Add'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: GetBuilder<PixelAddLogic>(builder: (_) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            RepaintBoundary(
              key: _repaintKey,
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.currentList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 20,
                  ),
                  itemBuilder: (_, index) {
                    var item = controller.currentList[index];
                    return Container()
                        .decorated(color: item.colorCode)
                        .gestures(onTap: () {
                      item.colorCode = colorList[controller.currentIndex];
                      controller.update();
                    });
                  }).marginSymmetric(vertical: 30),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: <Widget>[
                const Text(
                  'Select color',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: colorList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 9,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    itemBuilder: (_, index) {
                      return Container(
                        child: Visibility(
                            visible: index == controller.currentIndex,
                            child: const Icon(
                              Icons.check,
                              color: Colors.grey,
                              size: 20,
                            )),
                      )
                          .decorated(
                              color: colorList[index],
                              border:
                                  Border.all(color: const Color(0xffa3a3a3)))
                          .gestures(onTap: () {
                        controller.currentIndex = index;
                        controller.update();
                      });
                    })
              ].toColumn(),
            ).decorated(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xffe6e6e6))),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              child: const Text(
                'Save work',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            )
                .decorated(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12))
                .gestures(onTap: () async {
                  await _captureImage();
                  if (controller.image != null) {
                    controller.save();
                  } else {
                    Fluttertoast.showToast(msg: 'Please try again');
                  }

            })
          ].toColumn(),
        );
      }).marginAll(15)),
    );
  }
}
