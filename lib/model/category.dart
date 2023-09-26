import '../const/const.dart';

class Category {
  int id = 0;
  String name = "", image = "";

  Category();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      columnMainCategoryId: id,
      columnCategoryName: name,
    };
  }

  Category.fromMap(Map<String, dynamic> map) {
    id = map[columnMainCategoryId];
    name = map[columnCategoryName];
  }
}
