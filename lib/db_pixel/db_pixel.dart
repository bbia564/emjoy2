import 'dart:convert';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:pixel_photo/db_pixel/pixel_entity.dart';
import 'package:sqflite/sqflite.dart';


class DBPixel extends GetxService {
  late Database dbBase;

  Future<DBPixel> init() async {
    await createPixelDB();
    return this;
  }

  createPixelDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'pixel.db');

    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await createPixelTable(db);
        });
  }

  createPixelTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS pixel (id INTEGER PRIMARY KEY, createdTime TEXT, title TEXT, list TEXT, image BLOB)');
  }

  insertPixel(PixelEntity entity) async {
    final id = await dbBase.insert('pixel', {
      'createdTime': entity.createdTime.toIso8601String(),
      'title': entity.title,
      'list': jsonEncode(entity.list.map((e) => e.toJson()).toList()),
      'image': entity.image,
    });
    return id;
  }

  updatePixel(PixelEntity entity) async {
    await dbBase.update('pixel', {
      'title': entity.title,
      'list': jsonEncode(entity.list.map((e) => e.toJson()).toList()),
      'image': entity.image,
    }, where: 'id = ?', whereArgs: [entity.id]);
  }

  deletePixels(List<PixelEntity> list) async {
    await dbBase.delete('pixel', where: 'id IN (${list.map((e) => e.id).join(',')})');
  }

  cleanPixelsData() async {
    await dbBase.delete('pixel');
  }

  Future<List<PixelEntity>> getPixelAllData() async {
    var result = await dbBase.query('pixel', orderBy: 'createdTime DESC');
    return result.map((e) => PixelEntity.fromJson(e)).toList();
  }
}
