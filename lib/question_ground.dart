import 'package:flutter/material.dart';
import 'package:flutter_application_1/data_loader.dart';
import 'widgets/question.dart';
import 'single_question_answer_set.dart';
import 'dart:developer' as developer;

// Main Home Screen
class QuestionGround extends StatefulWidget {
  const QuestionGround({
    super.key,
    required this.filePath,
    required this.title,
    required this.questionAnswerSetDataList,
  });

  final String filePath;
  final String title;
  final List<QuestionAnswerSetData> questionAnswerSetDataList;

  @override
  State<QuestionGround> createState() => _QuestionGroundState();
}

class _QuestionGroundState extends State<QuestionGround> {
  late List<QuestionAnswerSetData> questionAnswerSetDataList;
  List<String> selectedAnswers = []; // Global list to store selected answers

  @override
  void initState() {
    super.initState();
    // Assign the passed questionAnswerSetDataList to the local variable
    questionAnswerSetDataList = widget.questionAnswerSetDataList;
  }

  void updateSelectedAnswers(List<String> selectedAnswers) {
    setState(() {
      this.selectedAnswers = selectedAnswers;
    });
  }

  // Function to handle submit action

  Future<void> handleSubmit() async {
    // Append "_answer" to the filename
    String modifiedPath = widget.filePath.replaceAll('.json', '_answer.json');
    developer.log("path: $modifiedPath");

    // Use the DataLoader class to load the data
    var answerSet = await DataLoader.loadDataAnswerSheet(modifiedPath);

    developer.log("selectedAnswers: $selectedAnswers");
    developer.log("answerSet: $answerSet");

    // Convert lists to sets of double values for comparison
    var selectedSet = selectedAnswers.map(double.parse).toSet();
    var answerSetP = answerSet.cast<double>().toSet();

    // Find the intersection of sets to get matching elements
    var matchingSet = selectedSet.intersection(answerSetP);

    developer.log("Matching elements: $matchingSet");

    // Get the count of matching elements
    int matchingCount = matchingSet.length;

    double calculatedScore = (matchingCount / answerSet.length) * 100;
    int ceilingScore = calculatedScore.ceil().toInt();

    developer.log("Calculated Score: $calculatedScore");

    developer.log("Number of matching elements: $matchingCount");

    showSubmitDialog(ceilingScore);
  }

  void showSubmitDialog(int calculatedScore) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Score: $calculatedScore'),
          content: const Text('Don\'t slack off in your efforts...'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Handle saving to the app
                Navigator.pushNamed(context, '/MyHomePage');
              },
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
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
            // Loop through each QuestionAnswerSet data and create a QuestionAnswerSet widget
            for (var data in questionAnswerSetDataList)
              SingleQuestionAnswerSet(
                questionTitle: data.questionTitle,
                questionText: data.questionText,
                answerOptions: data.answerOptions,
                selectedAnswers: selectedAnswers, // Pass selectedAnswers down
                updateSelectedAnswers: (value) {
                  setState(() {
                    selectedAnswers = value;
                  });
                },
              ),
            // Submit Button
            ElevatedButton(
              onPressed: handleSubmit,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
      endDrawer: const AppDrawer(),
    );
  }
}
