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

  Future<List<Question>> getQuestion(Database db) async {
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
        limit: 30,
        orderBy: "RANDOM()");
    if (maps.isNotEmpty) {
      return maps.map((question) => Question.fromMap(question)).toList();
    }
    return List<Question>.empty();
  }

  Future<Question> getQuestionById(Database db, int questionId) async {
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
        where: '$columnId = ?',
        whereArgs: [questionId]);
    if (maps.isNotEmpty) {
      return Question.fromMap(maps.first);
    }
    return Question();
  }
}
