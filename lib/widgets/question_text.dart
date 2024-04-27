import 'package:flutter/material.dart';

BoxDecoration containerDecoration = BoxDecoration(
  color: Colors.white,
  border: Border.all(
    color: Colors.blue,
    width: 1,
  ),
  borderRadius: BorderRadius.circular(8),
);

/// A widget that conditionally renders a `QuestionTextWithImage`,
/// `QuestionTextWithSmallImage`, or `QuestionText` based on the
/// provided `QuestionTextData` object.
class ConditionalQuestionText extends StatelessWidget {
  /// The data used to determine which widget to render.
  final QuestionTextData questionTextData;

  /// Creates a `ConditionalQuestionText` widget.
  ///
  /// The [questionTextData] argument must not be null.
  const ConditionalQuestionText({
    super.key,
    required this.questionTextData,
  });

  @override

  /// Builds the widget based on the provided `QuestionTextData`.
  ///
  /// This method checks if the question has a small image. If it does,
  /// it then checks if the question has a large image. Depending on the
  /// results of these checks, it renders a `QuestionTextWithImage`,
  /// `QuestionTextWithSmallImage`, or `QuestionText` widget.
  ///
  /// The `QuestionTextWithImage` widget is rendered if the question has both
  /// a small and a large image. The `QuestionTextWithSmallImage` widget is
  /// rendered if the question has a small image but no large image. The
  /// `QuestionText` widget is rendered if the question has no images.
  @override
  Widget build(BuildContext context) {
    // Check if the question has a small image
    if (questionTextData.hasSmallImage) {
      // Check if the question has a large image
      if (questionTextData.hasLargeImage) {
        // Render a `QuestionTextWithImage` widget
        return QuestionTextWithImage(
          questionTextData: questionTextData,
        );
      } else {
        // Render a `QuestionTextWithSmallImage` widget
        return QuestionTextWithSmallImage(
          questionTextData: questionTextData,
        );
      }
    } else {
      // Render a `QuestionText` widget
      return QuestionText(
        quesText: questionTextData.quesText,
      );
    }
  }
}

class QuestionTextWithImage extends StatelessWidget {
  // Represents a widget that displays a question text with an image.

  final QuestionTextData questionTextData;

  // Constructs a `QuestionTextWithImage` widget.
  const QuestionTextWithImage({
    super.key,
    required this.questionTextData,
  });

  @override
  Widget build(BuildContext context) {
    // Splits the question text into a list of words.
    final List<String> words = questionTextData.quesText.split(" ");
    // Checks if there is a small image.
    final bool isbetweenTextWithPic = questionTextData.hasSmallImage;
    // Gets the index of the small image in the question text.
    final int index = questionTextData.smallPicSpaceCount ?? 0;

    if (words.length > index) {
      // Builds the widget based on the given conditions.
      return _buildWidget(context, words, index, isbetweenTextWithPic);
    } else {
      // Returns an empty container if the conditions are not met.
      return Container();
    }
  }

  Widget _buildWidget(
    BuildContext context,
    List<String> words,
    int index,
    bool isbetweenTextWithPic,
  ) {
    return Container(
      width: double.infinity,
      decoration: containerDecoration,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (questionTextData.islargePicAbove ?? false)
              _buildLargeImage(questionTextData.largeImageProvider),
            if (isbetweenTextWithPic) _buildRichText(context, words, index),
            if (questionTextData.islargePicAbove == false)
              _buildLargeImage(questionTextData.largeImageProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildRichText(
    BuildContext context,
    List<String> words,
    int index,
  ) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(text: words.take(index).join(" ")),
          WidgetSpan(
            child: _buildSmallImage(questionTextData.smallImageProvider),
          ),
          TextSpan(text: words.skip(index).join(" ")),
        ],
      ),
    );
  }

  Widget _buildSmallImage(ImageProvider? imageProvider) {
    return Image(
      image: imageProvider ?? const AssetImage('assets/images/noimage50.png'),
      height: 50,
    );
  }

  Widget _buildLargeImage(ImageProvider? imageProvider) {
    return Image(
      image: imageProvider ?? const AssetImage('assets/images/noimage300.png'),
      height: 250,
    );
  }
}

class QuestionTextWithSmallImage extends StatelessWidget {
  final QuestionTextData questionTextData;

  const QuestionTextWithSmallImage({
    super.key,
    required this.questionTextData,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> words = questionTextData.quesText.split(" ");
    final index = questionTextData.smallPicSpaceCount ?? 0;

    if (words.length > index) {
      return Container(
        width: double.infinity,
        decoration: containerDecoration,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildRichText(
            context,
            words,
            index,
            questionTextData.smallImageProvider,
          ),
        ),
      );
    } else {
      return Container(); // or any other fallback widget
    }
  }

  Widget _buildRichText(
    BuildContext context,
    List<String> words,
    int index,
    ImageProvider? smallImageProvider,
  ) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(text: words.take(index).join(" ")),
          WidgetSpan(
            child: _buildSmallImage(smallImageProvider),
          ),
          TextSpan(text: words.skip(index).join(" ")),
        ],
      ),
    );
  }

  Widget _buildSmallImage(ImageProvider? imageProvider) {
    return Image(
      image: imageProvider ?? const AssetImage('assets/images/noimage50.png'),
      height: 50,
    );
  }
}

class QuestionText extends StatelessWidget {
  final String quesText;

  const QuestionText({super.key, required this.quesText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: containerDecoration,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(quesText),
      ),
    );
  }
}

/*
 * This class holds the data for a question text widget.
 * 
 * It includes the question text itself, and optionally, an image for the small or large version of the widget.
 * It also includes data for the placement of the small image in the question text.
 */
class QuestionTextData {
  /* The text of the question */
  final String quesText;

  /* The image provider for the small image, if any */
  final ImageProvider? smallImageProvider;

  /* The image provider for the large image, if any */
  final ImageProvider? largeImageProvider;

  /* The index of the small image in the question text, if any. Null if no small image. */
  final int? smallPicSpaceCount;

  /* Whether the large image should be displayed above the question text. Null if no large image. */
  final bool? islargePicAbove;

  /* Whether the question text has a small image */
  bool get hasSmallImage => smallImageProvider != null;

  /* Whether the question text has a large image */
  bool get hasLargeImage => largeImageProvider != null;

  /* Constructs a QuestionTextData object with the given data */
  QuestionTextData({
    required this.quesText,
    this.smallImageProvider,
    this.smallPicSpaceCount,
    this.islargePicAbove,
    this.largeImageProvider,
  });
}
