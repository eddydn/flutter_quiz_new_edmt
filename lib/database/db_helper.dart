import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


import '../const/const.dart';

Future<Database> copyDB() async {
  var dbPath = await getDatabasesPath();
  var path = join(dbPath, dbName);

  var exists = await databaseExists(path);
  if (!exists) {
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    //Copy from assets
    ByteData data = await rootBundle.load(join("assets/db", dbName));
    List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes, flush: true);
  } else {
    //If already have database in directory, just read it
    print("Opening DB...");
  }
  return await openDatabase(path, readOnly: true);
}