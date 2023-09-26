class UserAnswer {
  int questionId = 0;
  String answer = "";
  bool isCorrect = false;

  UserAnswer(
      {required this.questionId,
      required this.answer,
      required this.isCorrect});

  Map toJson() =>
      {'questionId': questionId, 'answer': answer, 'isCorrect': isCorrect};
}
