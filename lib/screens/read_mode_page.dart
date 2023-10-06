import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_new_edmt/model/category.dart';
import 'package:flutter_quiz_new_edmt/state/state_management.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/quiz_domain.dart';
import '../model/question.dart';
import '../model/user_answer.dart';
import '../widgets/question_body_widget.dart';
import '../const/const.dart';

class ReadModePage extends StatefulWidget {
  const ReadModePage({super.key});

  @override
  State<StatefulWidget> createState() => _ReadModePageState();
}

class _ReadModePageState extends State<ReadModePage> {
  List<UserAnswer> userAnswer = List<UserAnswer>.empty();
  int indexPage = 0;
  late SharedPreferences prefs;
  CarouselController buttonCarouselController = CarouselController();

  Future<int> getIndexPageFromCache() {
    if (prefs == null) return Future.value(0);
    return Future.value(prefs.getInt(
        '${questionCategoryState.value.name}_${questionCategoryState.value.id}'));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      prefs = await SharedPreferences.getInstance();
      indexPage = await getIndexPageFromCache();
      Future.delayed(const Duration(microseconds: 500)).then((value) => {
            if (buttonCarouselController != null && !isEmptyQuestion.value)
              buttonCarouselController.animateToPage(indexPage ?? 0)
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(),
          body: Container(
            color: Colors.white,
            child: FutureBuilder(
              future: getQuestionByModule(questionCategoryState.value.id),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  var questions = snapshot.data as List<Question>;
                  isEmptyQuestion.value = questions.isEmpty;
                  return questions.isEmpty
                      ? const Center(
                          child: Text('This category contains no question'),
                        )
                      : Container(
                          margin: const EdgeInsets.all(4),
                          child: Card(
                            elevation: 8,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 4, right: 4, bottom: 4, top: 10),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    QuestionBody(
                                      context: context,
                                      controller: buttonCarouselController,
                                      questions: questions,
                                      userAnswers: userAnswer,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              showAnswer(context);
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 8),
                                              child: Column(
                                                children: [
                                                  Icon(
                                                    Icons.question_answer,
                                                    color: Colors.grey,
                                                  ),
                                                  Text('Show Answer')
                                                ],
                                              ),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
        onWillPop: () async {
          showCloseDialog(questionCategoryState.value);
          return true;
        });
  }

  void showCloseDialog(Category value) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text('Close'),
              content: const Text('Do you want to save to view late?'),
              actions: [
                OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pop(context);
                    },
                    child: const Text('No')),
                OutlinedButton(
                    onPressed: () {
                      prefs.setInt(
                          '${questionCategoryState.value.name}_${questionCategoryState.value.id}',
                          currentReadPage.value);
                      Navigator.of(context).pop();
                      Navigator.pop(context);
                    },
                    child: const Text('Yes'))
              ],
            ));
  }

  void showAnswer(BuildContext context) {
    isEnableShowAnswer.value = true;
  }
}
