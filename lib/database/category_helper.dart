import 'package:flutter_quiz_new_edmt/const/const.dart';
import 'package:sqflite/sqflite.dart';

import '../model/category.dart';

class CategoryHelper {
  Future<List<Category>> getCategories(Database db) async {
    List<Map<String, dynamic>> maps = await db.query(tableCategoryName,
        columns: [columnMainCategoryId, columnCategoryName]);
    if (maps.isNotEmpty) {
      return maps.map((category) => Category.fromMap(category)).toList();
    }
    return List<Category>.empty(growable: true);
  }

  Future close(Database db) async => db.close();
}
