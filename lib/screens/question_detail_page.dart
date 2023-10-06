import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_new_edmt/state/state_management.dart';
import 'package:get/get.dart';

class QuestionDetailPage extends StatelessWidget {
  const QuestionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Obx(() => Text(
                'No ${userViewQuestionState.value.questionId} (in Database)')),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              Expanded(
                  child: Column(
                children: [
                  Obx(() => AutoSizeText(
                        userViewQuestionState.value.questionText,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxFontSize: 14,
                        textAlign: TextAlign.justify,
                      )),
                  userViewQuestionState.value.isImageQuestion != 0
                      ? SizedBox(
                          height: MediaQuery.sizeOf(context).height / 15 * 3,
                          child: Image.network(
                            '${userViewQuestionState.value.questionImage}',
                            fit: BoxFit.fill,
                          ),
                        )
                      : Container(),
                  Expanded(
                      child: ListTile(
                        title: AutoSizeText(
                          userViewQuestionState.value.answerA,
                          style: TextStyle(
                              color: isEnableShowAnswer.value
                                  ? userViewQuestionState.value.correctAnswer == 'A'
                                  ? Colors.red
                                  : Colors.grey
                                  : Colors.black),
                        ),
                        leading: Radio(
                          value: 'A',
                          groupValue: userViewQuestionState.value.correctAnswer,
                          onChanged: null,
                        ),
                      )),
                  Expanded(
                      child: ListTile(
                        title: AutoSizeText(
                          userViewQuestionState.value.answerB,
                          style: TextStyle(
                              color: isEnableShowAnswer.value
                                  ? userViewQuestionState.value.correctAnswer == 'B'
                                  ? Colors.red
                                  : Colors.grey
                                  : Colors.black),
                        ),
                        leading: Radio(
                          value: 'B',
                          groupValue: userViewQuestionState.value.correctAnswer,
                          onChanged: null,
                        ),
                      )),
                  Expanded(
                      child: ListTile(
                        title: AutoSizeText(
                          userViewQuestionState.value.answerC,
                          style: TextStyle(
                              color: isEnableShowAnswer.value
                                  ? userViewQuestionState.value.correctAnswer == 'C'
                                  ? Colors.red
                                  : Colors.grey
                                  : Colors.black),
                        ),
                        leading: Radio(
                          value: 'C',
                          groupValue: userViewQuestionState.value.correctAnswer,
                          onChanged: null,
                        ),
                      )),
                  Expanded(
                      child: ListTile(
                        title: AutoSizeText(
                          userViewQuestionState.value.answerD,
                          style: TextStyle(
                              color: isEnableShowAnswer.value
                                  ? userViewQuestionState.value.correctAnswer == 'D'
                                  ? Colors.red
                                  : Colors.grey
                                  : Colors.black),
                        ),
                        leading: Radio(
                          value: 'D',
                          groupValue: userViewQuestionState.value.correctAnswer,
                          onChanged: null,
                        ),
                      )),
                ],
              ))
            ]),
          ),
        ),
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        });
  }
}
