import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixel_photo/pages/pixel_add/pixel_text_field.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../main.dart';
import 'feedback_logic.dart';

class FeedbackPage extends GetView<FeedbackLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        backgroundColor: Colors.white,
        actions: [
          Text(
            'Commit',
            style: TextStyle(color: primaryColor),
          ).marginOnly(right: 20).gestures(onTap: () {
            controller.commit();
          })
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: GetBuilder<FeedbackLogic>(builder: (_) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    child: <Widget>[
                      const Text('Content'),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        child: PixelTextField(
                            maxLength: 300,
                            maxLines: 6,
                            value: controller.content,
                            onChange: (value) {
                              controller.content = value;
                            }),
                      ).decorated(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[300]!)),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text('Image'),
                      const SizedBox(
                        height: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 88,
                          height: 88,
                          child: controller.image == null
                              ? const Icon(
                            Icons.add_a_photo,
                            size: 40,
                            color: Colors.grey,
                          )
                              : Image.memory(
                            controller.image!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                            .decorated(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12))
                            .gestures(onTap: () {
                          controller.imageSelected();
                        }),
                      ),
                    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
                  ).decorated(
                      color: Colors.white, borderRadius: BorderRadius.circular(12))
                ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
              );
            }).marginAll(15)),
      ),
    );
  }
}
