import 'package:sqflite/sqflite.dart';

import '../const/const.dart';
import '../model/question.dart';

class QuestionHelper {
  Future<List<Question>> getQuestionByModule(
      Database db, int categoryId) async {
    var maps = await db.query(tableName,
        columns: [
          columnId,
          columnCategoryId,
          columnText,
          columnImage,
          columnAnswerA,
          columnAnswerB,
          columnAnswerC,
          columnAnswerD,
          columnCorrectAnswer,
          columnIsImageQuestion
        ],
        where: '$columnCategoryId = ?',
        whereArgs: [categoryId]);
    if (maps.isNotEmpty) {
      return maps.map((question) => Question.fromMap(question)).toList();
    }
    return List<Question>.empty();
  }
}
