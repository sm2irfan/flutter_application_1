import 'dart:ffi';

import 'package:flutter/material.dart';
import 'widgets/answer_option.dart';
import 'widgets/question.dart';

class RevHome extends StatefulWidget {
  const RevHome({super.key, required this.title});

  final String title;

  @override
  State<RevHome> createState() => _RevHomeState();
}

class _RevHomeState extends State<RevHome> {
  double selectedAnswer = 0;

  Color getAnswerBoxColor(double boxNumber) {
    return selectedAnswer == boxNumber ? Colors.yellow : Colors.white;
  }

  void selectAnswer(double boxNumber) {
    setState(() {
      selectedAnswer = boxNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        const SizedBox(height: 30),
        questioAnswerSet(),
        const SizedBox(height: 30),
      ])),
      drawer: const AppDrawer(),
    );
  }

  Padding questioAnswerSet() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: <Widget>[
                  const QuestionTitle(),
                  const SizedBox(height: 8),
                  const QuestionText(),
                  const SizedBox(height: 8),
                  AnswerOption(
                    answerPlace: "A",
                    answerText: "First Answer",
                    color: getAnswerBoxColor(1.1),
                    onTap: () => selectAnswer(1.1),
                  ),
                  const SizedBox(height: 8),
                  AnswerOption(
                    answerPlace: "B",
                    answerText: "Second Answer",
                    color: getAnswerBoxColor(1.2),
                    onTap: () => selectAnswer(1.2),
                  ),
                  const SizedBox(height: 8),
                  AnswerOption(
                    answerPlace: "C",
                    answerText: "Third Answer",
                    color: getAnswerBoxColor(1.3),
                    onTap: () => selectAnswer(1.3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
