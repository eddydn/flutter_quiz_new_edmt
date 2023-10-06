import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_new_edmt/model/question.dart';
import 'package:flutter_quiz_new_edmt/state/state_management.dart';
import 'package:get/get.dart';

import '../const/const.dart';
import '../domain/quiz_domain.dart';
import '../model/user_answer.dart';
import '../widgets/count_down_widget.dart';
import '../widgets/question_body_widget.dart';

class TestModePage extends StatefulWidget {
  const TestModePage({super.key});

  @override
  State<StatefulWidget> createState() => _TestModePageState();
}

class _TestModePageState extends State<TestModePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<UserAnswer> userAnswer = List<UserAnswer>.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(seconds: limitTime));

    _controller.addListener(() {
      if (_controller.isCompleted) {
        Navigator.pop(context);
        Navigator.pushNamed(context, "/testResult");
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    if (_controller.isAnimating || _controller.isCompleted) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CarouselController buttonCarouselController = CarouselController();
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Obx(() =>
                Text(questionCategoryState.value.name.replaceAll('\n', ' '))),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                        onPressed: () => onAnswerSheetClick(),
                        child: const Column(
                          children: [Icon(Icons.note), Text('Answer Sheet')],
                        )),
                    CountDown(
                      animation: StepTween(begin: limitTime, end: 0)
                          .animate(_controller),
                      listenable: _controller,
                    ),
                    ElevatedButton(
                        onPressed: () => onSubmitExamClick(),
                        child: const Column(
                          children: [Icon(Icons.done), Text('Submit')],
                        )),
                  ],
                ),
                FutureBuilder(
                  future: getQuestionForExamp(),
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
                        child: Text(
                            'This category contains no question'),
                      )
                          : Container(
                        margin: const EdgeInsets.all(4),
                        child: Card(
                          elevation: 8,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 4,
                                right: 4,
                                bottom: 4,
                                top: 10),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  QuestionBody(
                                    context: context,
                                    controller:
                                    buttonCarouselController,
                                    questions: questions,
                                    userAnswers: userAnswer,
                                  ),
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
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          showCloseExamDialog();
          return true;
        });
  }

  void showCloseExamDialog() async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text('Close'),
              content: const Text('Do you want to close?'),
              actions: [
                OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('No')),
                OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pop(context);
                    },
                    child: const Text('Yes')),
              ],
            ));
  }

  onAnswerSheetClick() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
              title: const Text('Your Examp'),
              content: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: Obx(() => GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 2.0,
                      padding: const EdgeInsets.all(4.0),
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      children: userListAnswer.value.asMap().entries.map((e) {
                        return GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: AutoSizeText(
                              'No ${e.key + 1}: ${e.value.answer == null || e.value.answer.isEmpty ? ' ' : e.value.answer}',
                              style: TextStyle(
                                  fontWeight: (e.value.answer != null &&
                                          e.value.answer.isNotEmpty)
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                              maxLines: 1,
                            ),
                          ),
                        );
                      }).toList(),
                    )),
              ),
              actions: [
                OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close')),
              ],
            ));
  }

  onSubmitExamClick() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text('Submit'),
              content: const Text('Do you really want to submit?'),
              actions: [
                OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close')),
                OutlinedButton(
                    onPressed: () {
                      userListAnswer.value = userAnswer;
                      Navigator.pop(context); // Close pop up
                      Navigator.of(context).pushReplacementNamed('/testResult');
                    },
                    child: const Text('Yes')),
              ],
            ));
  }

  Future<List<Question>> getQuestionForExamp() async {
    var result = await getExamQuestion();
    userAnswer.clear(); // Clear map
    for (var element in result) {
      userAnswer.add(UserAnswer(
          questionId: element.questionId, answer: '', isCorrect: false));
    }
    userListAnswer.value = userAnswer;
    return result;
  }
}
