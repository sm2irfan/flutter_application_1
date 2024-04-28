import 'package:flutter/material.dart';
import 'widgets/answer_option.dart';
import 'widgets/question_text.dart';
import 'widgets/question_title.dart';
import 'dart:developer' as developer;

// Widget to display a single QuestionAnswerSet
class SingleQuestionAnswerSet extends StatefulWidget {
  final String questionTitle;
  final QuestionTextData questionText;
  final List<AnswerOptionData> answerOptions;
  final List<String> selectedAnswers;
  final void Function(List<String>)
      updateSelectedAnswers; // Function to update selectedAnswers

  const SingleQuestionAnswerSet({
    super.key,
    required this.questionTitle,
    required this.questionText,
    required this.answerOptions,
    required this.selectedAnswers,
    required this.updateSelectedAnswers,
  });

  @override
  SingleQuestionAnswerSetState createState() => SingleQuestionAnswerSetState();
}

class SingleQuestionAnswerSetState extends State<SingleQuestionAnswerSet> {
  String selectedAnswer = '';
  String extractValue = '';
  String internalValue = '';

  // Get the color for the answer box based on the selected answer
  Color getAnswerBoxColor(String boxNumber) {
    return selectedAnswer == boxNumber ? Colors.yellow : Colors.white;
  }

  // Select an answer and update the selectedAnswers list
  void selectAnswer(String boxNumber) {
    RegExp regex = RegExp(r'(.+)(?=\.\d$)');
    setState(() {
      selectedAnswer = boxNumber;
      extractValue = regex.stringMatch(boxNumber)!;

      // Create a new list to store elements to be removed
      List<String> elementsToRemove = [];

      // Iterate over the selectedAnswers list and find elements to remove
      for (String element in widget.selectedAnswers) {
        String internalValue = regex.stringMatch(element)!;
        if (internalValue == extractValue) {
          elementsToRemove.add(element);
        }
      }

      // Remove the elements from the selectedAnswers list
      widget.selectedAnswers
          .removeWhere((element) => elementsToRemove.contains(element));

      // Add the selected answer to the selectedAnswers list
      widget.selectedAnswers.add(boxNumber);

      // Update the selectedAnswers list in the parent widget
      widget.updateSelectedAnswers(widget.selectedAnswers);
    });
    developer.log("testing 2: ${widget.selectedAnswers}");
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
                  ConditionalQuestionText(
                    questionData: widget.questionText,
                  ),
                  // quesText: widget.questionText,
                  // imageProvider: const AssetImage('assets/images/birdSmall.png')),
                  const SizedBox(height: 8),
                  // Loop through each answer option and create an AnswerOption widget
                  for (var option in widget.answerOptions)
                    AnswerOption(
                      answerPlace: option.answerPlace,
                      answerTextData: option.answerTextData,
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

// Data class to hold the properties of an AnswerOption
class AnswerOptionData {
  final String answerPlace;
  final AnswerTextData answerTextData;
  final String boxNumber;

  AnswerOptionData({
    required this.answerPlace,
    required this.answerTextData,
    required this.boxNumber,
  });
}

// Data class to hold the properties of QuestionAnswerSet
class QuestionAnswerSetData {
  final String questionTitle;
  final QuestionTextData questionText;
  final List<AnswerOptionData> answerOptions;

  QuestionAnswerSetData({
    required this.questionTitle,
    required this.questionText,
    required this.answerOptions,
  });

  @override
  String toString() {
    return 'QuestionTitle: $questionTitle, QuestionText: $questionText, AnswerOptions: $answerOptions';
  }
}
