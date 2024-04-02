import 'package:flutter/material.dart';
import 'widgets/answer_option.dart';
import 'widgets/question.dart';
import 'assets/data.dart'; // Import the data file
import 'data_parser.dart'; // Import the data parser file

class RevHome extends StatefulWidget {
  const RevHome({super.key, required this.title});

  final String title;

  @override
  State<RevHome> createState() => _RevHomeState();
}

class _RevHomeState extends State<RevHome> {
  late List<QuestionAnswerSetData> questionAnswerSetDataList;

  @override
  void initState() {
    super.initState();
    questionAnswerSetDataList = parseQuestionAnswerSets(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            for (var data in questionAnswerSetDataList)
              QuestionAnswerSet(
                questionTitle: data.questionTitle,
                questionText: data.questionText,
                answerOptions: data.answerOptions,
              ),
          ],
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}

class QuestionAnswerSet extends StatefulWidget {
  final String questionTitle;
  final String questionText;
  final List<AnswerOptionData> answerOptions;

  const QuestionAnswerSet({
    super.key,
    required this.questionTitle,
    required this.questionText,
    required this.answerOptions,
  });

  @override
  _QuestionAnswerSetState createState() => _QuestionAnswerSetState();
}

class _QuestionAnswerSetState extends State<QuestionAnswerSet> {
  double selectedAnswer = 0;

  Color getAnswerBoxColor(double boxNumber) {
    return selectedAnswer == boxNumber ? Colors.yellow : Colors.white;
  }

  void selectAnswer(double boxNumber) {
    print("testing 2: $boxNumber");
    setState(() {
      selectedAnswer = boxNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 201, 223, 241),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: <Widget>[
                  QuestionTitle(quesTitle: widget.questionTitle),
                  const SizedBox(height: 8),
                  QuestionText(quesText: widget.questionText),
                  const SizedBox(height: 8),
                  for (var option in widget.answerOptions)
                    AnswerOption(
                      answerPlace: option.answerPlace,
                      answerText: option.answerText,
                      color: getAnswerBoxColor(option.boxNumber),
                      onTap: () => selectAnswer(option.boxNumber),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class AnswerOptionData {
  final String answerPlace;
  final String answerText;
  final double boxNumber;

  AnswerOptionData({
    required this.answerPlace,
    required this.answerText,
    required this.boxNumber,
  });
}

// Data class to hold the properties of QuestionAnswerSet
class QuestionAnswerSetData {
  final String questionTitle;
  final String questionText;
  final List<AnswerOptionData> answerOptions;

  QuestionAnswerSetData({
    required this.questionTitle,
    required this.questionText,
    required this.answerOptions,
  });
}
