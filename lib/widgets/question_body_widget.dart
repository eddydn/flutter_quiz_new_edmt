import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_new_edmt/state/state_management.dart';
import 'package:get/get.dart';

import '../model/question.dart';
import '../model/user_answer.dart';

class QuestionBody extends StatelessWidget {
  QuestionBody(
      {super.key,
      required this.controller,
      required this.context,
      required this.questions,
      required this.userAnswers});

  BuildContext context;
  List<UserAnswer> userAnswers;
  CarouselController controller;
  List<Question> questions;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: questions
          .asMap()
          .entries
          .map((e) => Builder(
                builder: (context) {
                  return Column(
                    children: [
                      Expanded(
                          child: Obx(() => Column(
                                children: [
                                  AutoSizeText(
                                    isTestMode.value
                                        ? 'No ${e.key + 1}:${e.value.questionText}'
                                        : 'No ${e.value.questionId}:${e.value.questionText}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxFontSize: 14,
                                    textAlign: TextAlign.justify,
                                  ),
                                  Visibility(
                                    visible: (e.value.isImageQuestion == null ||
                                            e.value.isImageQuestion == 0)
                                        ? false
                                        : true,
                                    child: SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height /
                                              15 *
                                              3,
                                      child: e.value.isImageQuestion == 0
                                          ? Container()
                                          : Image.network(
                                              e.value.questionImage!!),
                                    ),
                                  ),
                                  Expanded(
                                      child: ListTile(
                                    title: AutoSizeText(
                                      e.value.answerA,
                                      style: TextStyle(
                                          color: isEnableShowAnswer.value
                                              ? e.value.correctAnswer == 'A'
                                                  ? Colors.red
                                                  : Colors.grey
                                              : Colors.black),
                                    ),
                                    leading: Radio(
                                      value: 'A',
                                      groupValue: getGroupValue(
                                          isEnableShowAnswer.value,
                                          e,
                                          userAnswerSelected.value),
                                      onChanged: (value) {
                                        setUserAnswer(context, e, value);
                                      },
                                    ),
                                  )),
                                  Expanded(
                                      child: ListTile(
                                        title: AutoSizeText(
                                          e.value.answerB,
                                          style: TextStyle(
                                              color: isEnableShowAnswer.value
                                                  ? e.value.correctAnswer == 'B'
                                                  ? Colors.red
                                                  : Colors.grey
                                                  : Colors.black),
                                        ),
                                        leading: Radio(
                                          value: 'B',
                                          groupValue: getGroupValue(
                                              isEnableShowAnswer.value,
                                              e,
                                              userAnswerSelected.value),
                                          onChanged: (value) {
                                            setUserAnswer(context, e, value);
                                          },
                                        ),
                                      )),
                                  Expanded(
                                      child: ListTile(
                                        title: AutoSizeText(
                                          e.value.answerC,
                                          style: TextStyle(
                                              color: isEnableShowAnswer.value
                                                  ? e.value.correctAnswer == 'C'
                                                  ? Colors.red
                                                  : Colors.grey
                                                  : Colors.black),
                                        ),
                                        leading: Radio(
                                          value: 'C',
                                          groupValue: getGroupValue(
                                              isEnableShowAnswer.value,
                                              e,
                                              userAnswerSelected.value),
                                          onChanged: (value) {
                                            setUserAnswer(context, e, value);
                                          },
                                        ),
                                      )),
                                  Expanded(
                                      child: ListTile(
                                        title: AutoSizeText(
                                          e.value.answerD,
                                          style: TextStyle(
                                              color: isEnableShowAnswer.value
                                                  ? e.value.correctAnswer == 'D'
                                                  ? Colors.red
                                                  : Colors.grey
                                                  : Colors.black),
                                        ),
                                        leading: Radio(
                                          value: 'D',
                                          groupValue: getGroupValue(
                                              isEnableShowAnswer.value,
                                              e,
                                              userAnswerSelected.value),
                                          onChanged: (value) {
                                            setUserAnswer(context, e, value);
                                          },
                                        ),
                                      ))
                                ],
                              )))
                    ],
                  );
                },
              ))
          .toList(),
      options: CarouselOptions(
          autoPlay: false,
          enlargeCenterPage: true,
          viewportFraction: 0.9,
          initialPage: 0,
          height: MediaQuery.sizeOf(context).height / 5 * 3,
          onPageChanged: (page, _) {
            currentReadPage.value = page;
            isEnableShowAnswer.value = false;
          }),
    );
  }

  getGroupValue(
      bool isShowAnswer, MapEntry<int, Question> e, UserAnswer userAnswer) {
    return isShowAnswer
        ? e.value.correctAnswer
        : isTestMode.value
            ? userListAnswer[e.key].answer
            : '';
  }

  void setUserAnswer(BuildContext context, MapEntry<int, Question> e, value) {
    userListAnswer.value[e.key] = userAnswerSelected.value = UserAnswer(
        questionId: e.value.questionId,
        answer: value,
        isCorrect: value.toString().isNotEmpty
            ? value.toString().toLowerCase() ==
                e.value.correctAnswer.toLowerCase()
            : false);
  }
}
