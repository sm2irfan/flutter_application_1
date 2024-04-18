import 'package:flutter/material.dart';
import 'package:flutter_application_1/data_loader.dart';
import 'widgets/answer_option.dart';
import 'widgets/question.dart';

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
    print("path: $modifiedPath");

    // Use the DataLoader class to load the data
    var answerSet = await DataLoader.loadData(modifiedPath);

    print("selectedAnswers: $selectedAnswers");
    print("answerSet: $answerSet");

    // Convert lists to sets of double values for comparison
    var selectedSet = selectedAnswers.map(double.parse).toSet();
    var answerSetP = answerSet.cast<double>().toSet();

    // Find the intersection of sets to get matching elements
    var matchingSet = selectedSet.intersection(answerSetP);

    print("Matching elements: $matchingSet");

    // Get the count of matching elements
    int matchingCount = matchingSet.length;

    double calculatedScore = (matchingCount / answerSet.length) * 100;
    int ceilingScore = calculatedScore.ceil().toInt();

    print("Calculated Score: $calculatedScore");

    print("Number of matching elements: $matchingCount");

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

// Widget to display a single QuestionAnswerSet
class SingleQuestionAnswerSet extends StatefulWidget {
  final String questionTitle;
  final String questionText;
  final List<AnswerOptionData> answerOptions;
  final List<String> selectedAnswers; // Pass selectedAnswers
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
  _SingleQuestionAnswerSetState createState() =>
      _SingleQuestionAnswerSetState();
}

class _SingleQuestionAnswerSetState extends State<SingleQuestionAnswerSet> {
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
    print("testing 2: ${widget.selectedAnswers}");
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
                  // Loop through each answer option and create an AnswerOption widget
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

// Data class to hold the properties of an AnswerOption
class AnswerOptionData {
  final String answerPlace;
  final String answerText;
  final String boxNumber;

  AnswerOptionData({
    required this.answerPlace,
    required this.answerText,
    required this.boxNumber,
  });
  @override
  String toString() {
    return 'answerPlace: $answerPlace, answerText: $answerText, boxNumber: $boxNumber';
  }
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

  @override
  String toString() {
    return 'QuestionTitle: $questionTitle, QuestionText: $questionText, AnswerOptions: $answerOptions';
  }
}
