import 'package:flutter/material.dart';

class ConditionalQuestionText extends StatelessWidget {
  final QuestionTextData questionTextData;

  const ConditionalQuestionText({
    super.key,
    required this.questionTextData,
  });

  @override
  Widget build(BuildContext context) {
    if (questionTextData.spaceCount != null &&
        questionTextData.imageProvider != null) {
      return QuestionTextWithImage(
        quesText: questionTextData.quesText,
        imageProvider: questionTextData.imageProvider!,
        spaceCount: questionTextData.spaceCount!,
      );
    } else {
      return QuestionText(
        quesText: questionTextData.quesText,
      );
    }
  }
}

class QuestionTextWithImage extends StatelessWidget {
  final String quesText;
  final ImageProvider imageProvider;
  final int spaceCount;

  const QuestionTextWithImage({
    super.key,
    required this.quesText,
    required this.imageProvider,
    required this.spaceCount,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> words = quesText.split(" ");
    int index = spaceCount; // Index of the word you want to use
    if (words.length > index) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.blue,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(text: words.take(index).join(" ")),
                WidgetSpan(
                  child: Image(
                    image: imageProvider,
                    height: 50, // Adjust the height as needed
                  ),
                ),
                TextSpan(text: words.skip(index).join(" ")),
              ],
            ),
          ),
        ),
      );
    } else {
      // Handle cases where there are fewer than 3 words in the text
      return Container(); // or any other fallback widget
    }
  }
}

class QuestionText extends StatelessWidget {
  final String quesText;

  const QuestionText({super.key, required this.quesText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.blue,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // adjust the padding as needed
        child: Text(quesText),
      ),
    );
  }
}

class QuestionTextData {
  final String quesText;
  final ImageProvider? imageProvider;
  final int? spaceCount; // Make spaceCount nullable

  QuestionTextData({
    required this.quesText,
    this.imageProvider,
    this.spaceCount, // Update spaceCount to be nullable
  });
}
