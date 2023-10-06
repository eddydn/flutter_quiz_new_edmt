import 'package:flutter_quiz_new_edmt/model/category.dart';
import 'package:get/get.dart';

import '../model/question.dart';
import '../model/user_answer.dart';

final categoryListState = [].obs;
final questionCategoryState = Category().obs;
final isTestMode = false.obs;
final currentReadPage = 0.obs;
final isEnableShowAnswer = false.obs;
final userAnswerSelected =
    UserAnswer(questionId: 0, answer: "", isCorrect: false).obs;
final userListAnswer = List<UserAnswer>.empty(growable: true).obs;

final isEmptyQuestion = true.obs;
final userViewQuestionState = Question().obs;
