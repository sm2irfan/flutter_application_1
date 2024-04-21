import 'package:flutter/material.dart';

class QuestionTextWithImage extends StatelessWidget {
  final String quesText;
  final ImageProvider imageProvider;

  const QuestionTextWithImage({
    super.key,
    required this.quesText,
    required this.imageProvider,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> words = quesText.split(" ");
    int index = 1; // Index of the word you want to use
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
                    height: 30, // Adjust the height as needed
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

class QuestionTextWithImageData {
  final ImageProvider imageProvider;
  final String spaceCount;

  QuestionTextWithImageData({
    required this.imageProvider,
    required this.spaceCount,
  });
  @override
  String toString() {
    return 'url: $imageProvider, spaceCount: $spaceCount,';
  }
}
