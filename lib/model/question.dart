import '../const/const.dart';

class Question {
  int questionId = 0;
  int categoryId = 0;
  int isImageQuestion = 0;
  String questionText = "",
      answerA = "",
      answerB = "",
      answerC = "",
      answerD = "",
      correctAnswer = "";

  String? questionImage = ""; // url of image if is question image

  Question();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      columnId: questionId,
      columnText: questionText,
      columnImage: questionImage,
      columnAnswerA: answerA,
      columnAnswerB: answerB,
      columnAnswerC: answerC,
      columnAnswerD: answerD,
      columnCorrectAnswer: correctAnswer,
      columnIsImageQuestion: isImageQuestion
    };
  }

  Question.fromMap(Map<String, dynamic> map) {
    questionId = map[columnId];
    categoryId = map[columnCategoryId];
    questionText = map[columnText];
    answerA = map[columnAnswerA];
    answerB = map[columnAnswerB];
    answerC = map[columnAnswerC];
    answerD = map[columnAnswerD];
    correctAnswer = map[columnCorrectAnswer];
    isImageQuestion = map[columnIsImageQuestion];
    if (map[columnIsImageQuestion] != 0) questionImage = map[columnImage];
  }
}
