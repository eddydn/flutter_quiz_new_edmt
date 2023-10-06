import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_new_edmt/state/state_management.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../domain/quiz_domain.dart';

class TestResultPage extends StatelessWidget {
  const TestResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Result'),
          ),
          body: Container(
            color: Colors.white10,
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const AutoSizeText(
                  'Limit',
                  style: TextStyle(color: Colors.blueAccent),
                  maxLines: 1,
                ),
                LinearPercentIndicator(
                  lineHeight: 14.0,
                  percent: 0.5,
                  backgroundColor: Colors.grey,
                  progressColor: Colors.blue,
                ),
                AutoSizeText(
                  'Your mark: ${((10.0 / userListAnswer.value.length) * userListAnswer.value.where((element) => element.isCorrect).toList().length).toStringAsFixed(1)}/10.0',
                  style: const TextStyle(color: Colors.blueAccent),
                  maxLines: 1,
                ),
                LinearPercentIndicator(
                  lineHeight: 14.0,
                  percent: userListAnswer.value
                          .where((element) => element.isCorrect)
                          .toList()
                          .length /
                      userListAnswer.value.length,
                  backgroundColor: Colors.brown,
                  progressColor: Colors.red,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text('Correct Answer')
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text('Wrong Answer')
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            color: Colors.white70,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text('Not Done')
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: GridView.count(
                  crossAxisCount: 5,
                  childAspectRatio: 1.0,
                  padding: const EdgeInsets.all(2.0),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  children: userListAnswer.value.asMap().entries.map((e) {
                    return GestureDetector(
                      onTap: () async {
                        var question = await getQuestionById(e.value.questionId);
                        userViewQuestionState.value = question;
                        if (!context.mounted) return;
                        Navigator.pushNamed(context, '/questionDetail');
                      },
                      child: Card(
                        elevation: 2,
                        color: e.value.answer.isEmpty
                            ? Colors.white70
                            : e.value.isCorrect
                                ? Colors.green
                                : Colors.red,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                'No ${e.key + 1}\n ${e.value.answer}',
                                style: TextStyle(
                                    color: e.value.answer.isEmpty
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ))
              ],
            ),
          ),
        ),
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        });
  }
}
