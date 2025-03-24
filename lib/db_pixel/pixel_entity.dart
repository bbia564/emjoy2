import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class PixelEntity {
  int id;
  DateTime createdTime;
  String title;
  List<ColorEntity> list;
  Uint8List image;

  PixelEntity({
    required this.id,
    required this.createdTime,
    required this.title,
    required this.list,
    required this.image
  });

  factory PixelEntity.fromJson(Map<String, dynamic> json) {
    return PixelEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['createdTime']),
      title: json['title'],
      list: (jsonDecode(json['list']) as List)
          .map((e) => ColorEntity.fromJson(e))
          .toList(),
      image: Uint8List.fromList(json['image'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime.toIso8601String(),
      'title': title,
      'list': jsonEncode(list.map((e) => e.toJson()).toList()),
      'image': image
    };
  }
}

class ColorEntity {
  int colorIndex;
  Color colorCode;

  ColorEntity({
    required this.colorIndex,
    required this.colorCode
  });

  factory ColorEntity.fromJson(Map<String, dynamic> json) {
    return ColorEntity(
      colorIndex: json['colorIndex'],
      colorCode: Color(json['colorCode'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'colorIndex': colorIndex,
      'colorCode': colorCode.value
    };
  }
}