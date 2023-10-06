import '../database/db_helper.dart';
import '../database/question_helper.dart';
import '../model/question.dart';

Future<List<Question>> getQuestionByModule(int categoryId) async {
  var db = await copyDB();
  return await QuestionHelper().getQuestionByModule(db, categoryId);
}

Future<Question> getQuestionById(int questionId) async {
  var db = await copyDB();
  return await QuestionHelper().getQuestionById(db, questionId);
}

Future<List<Question>> getExamQuestion() async {
  var db = await copyDB();
  return await QuestionHelper().getQuestion(db);
}