import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'pixel_main_logic.dart';

class PixelMainPage extends StatefulWidget {
  const PixelMainPage({Key? key}) : super(key: key);

  @override
  State<PixelMainPage> createState() => _PixelMainPageState();
}

class _PixelMainPageState extends State<PixelMainPage> {

  PixelMainLogic controller = Get.find();

  void checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      Get.toNamed('/networkCheck');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    checkNetwork();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: GetBuilder<PixelMainLogic>(builder: (_) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: <Widget>[
                  const Text(
                    'Pixel Pic',
                    style: TextStyle(fontSize: 53, color: Colors.white),
                  ),
                  const Text(
                    'Create your pixel painting',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Container(
                    width: double.infinity,
                    height: 44,
                    child: <Widget>[
                      const Icon(
                        Icons.add,
                        size: 25,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Start create',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ].toRow(mainAxisAlignment: MainAxisAlignment.center),
                  )
                      .decorated(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15))
                      .marginSymmetric(vertical: 15)
                      .gestures(onTap: () {
                    Get.toNamed('/pixelAdd')?.then((value) {
                      controller.getData();
                    });
                  }),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    child: <Widget>[
                      <Widget>[
                        const Text(
                          'My work',
                          style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                        controller.isEdit
                            ? <Widget>[
                          const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.black),
                          ).gestures(onTap: () {
                            controller.isEdit = !controller.isEdit;
                            controller.selectedList.clear();
                            controller.update();
                          }),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text(
                            'Delete',
                            style: TextStyle(color: Color(0xffff0000)),
                          ).gestures(onTap: () {
                            controller.deleteSelected();
                          })
                        ].toRow(mainAxisAlignment: MainAxisAlignment.end)
                            : <Widget>[
                          const Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'Edit',
                          )
                        ]
                            .toRow(mainAxisAlignment: MainAxisAlignment.end)
                            .gestures(onTap: () {
                          controller.isEdit = !controller.isEdit;
                          controller.update();
                        })
                      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(() {
                        return controller.list.value.isEmpty
                            ? const Center(
                          child: Text('No data'),
                        )
                            : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.list.value.length,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 20,
                                childAspectRatio: 59 / 85),
                            itemBuilder: (_, index) {
                              final entity = controller.list.value[index];
                              return <Widget>[
                                <Widget>[
                                  AspectRatio(
                                    aspectRatio: 1,
                                    child: Image.memory(
                                      entity.image,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Visibility(
                                      visible: controller.selectedList
                                          .contains(entity),
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Container().decorated(
                                            color: const Color(0xfff2f2f2)
                                                .withOpacity(0.6)),
                                      )),
                                  Visibility(
                                    visible: controller.isEdit,
                                    child: Positioned(
                                        top: 8,
                                        right: 5,
                                        child: Image.asset(
                                          'assets/${controller.selectedList.contains(entity) ? 'selected' : 'unselect'}.webp',
                                          width: 14,
                                          height: 14,
                                          fit: BoxFit.cover,
                                        )),
                                  )
                                ].toStack(),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  entity.title,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ].toColumn().gestures(onTap: () {
                                if (controller.isEdit) {
                                  if (controller.selectedList
                                      .contains(entity)) {
                                    controller.selectedList.remove(entity);
                                  } else {
                                    controller.selectedList.add(entity);
                                  }
                                  controller.update();
                                } else {
                                  Get.toNamed('/pixelAdd',
                                      arguments: entity)
                                      ?.then((_) {
                                    controller.getData();
                                  });
                                }
                              });
                            });
                      })
                    ].toColumn(),
                  ).decorated(
                      color: const Color(0xffe6e6e6),
                      borderRadius: BorderRadius.circular(15)),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    alignment: Alignment.center,
                    child: const Text(
                      'Setting',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  )
                      .decorated(
                      color: const Color(0xffe6e6e6),
                      borderRadius: BorderRadius.circular(15))
                      .gestures(onTap: () {
                    Get.toNamed('/pixelSetting')?.then((_) {
                      controller.getData();
                    });
                  })
                ].toColumn(),
              );
            }).marginAll(15)),
      ).decorated(
          image: const DecorationImage(
              image: AssetImage('assets/bg.webp'), fit: BoxFit.fill)),
    );
  }
}

