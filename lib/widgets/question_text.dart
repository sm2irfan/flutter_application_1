import 'package:flutter/material.dart';

class ConditionalQuestionText extends StatelessWidget {
  final QuestionTextData questionData;

  const ConditionalQuestionText({super.key, required this.questionData});

  @override
  Widget build(BuildContext context) {
    if (questionData.hasSmallImage && questionData.hasLargeImage) {
      return QuestionTextWithBothImages(questionData: questionData);
    } else if (questionData.hasSmallImage) {
      return QuestionTextWithSmallImage(questionData: questionData);
    } else {
      return QuestionTextWithLargeImage(questionData: questionData);
    }
  }
}

class QuestionTextWithBothImages extends StatelessWidget {
  final QuestionTextData questionData;

  const QuestionTextWithBothImages({
    super.key,
    required this.questionData,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> words = questionData.questionText?.split(" ") ?? [];
    final bool hasSmallImageInText = questionData.hasSmallImage;
    final int smallImageIndex = questionData.smallImageIndex ?? 0;

    if (words.length > smallImageIndex) {
      return _buildContainerWithContent(
          context, words, smallImageIndex, hasSmallImageInText);
    } else {
      return Container();
    }
  }

  Widget _buildContainerWithContent(
    BuildContext context,
    List<String> words,
    int smallImageIndex,
    bool hasSmallImageInText,
  ) {
    return DecoratedContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (questionData.isLargeImageAbove ?? false)
              ImageWidget(
                  imageProvider: questionData.largeImageProvider, height: 200),
            if (hasSmallImageInText)
              _buildRichTextWithImage(context, words, smallImageIndex),
            if (questionData.isLargeImageAbove == false)
              ImageWidget(
                  imageProvider: questionData.largeImageProvider, height: 200),
          ],
        ),
      ),
    );
  }

  Widget _buildRichTextWithImage(
    BuildContext context,
    List<String> words,
    int smallImageIndex,
  ) {
    return RichTextWidget(
      words: words,
      index: smallImageIndex,
      smallImageProvider: questionData.smallImageProvider,
    );
  }
}

class QuestionTextWithSmallImage extends StatelessWidget {
  final QuestionTextData questionData;

  const QuestionTextWithSmallImage({
    super.key,
    required this.questionData,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> words = questionData.questionText?.split(" ") ?? [];
    final int smallImageIndex = questionData.smallImageIndex ?? 0;

    if (words.length > smallImageIndex) {
      return DecoratedContainer(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichTextWidget(
            words: words,
            index: smallImageIndex,
            smallImageProvider: questionData.smallImageProvider,
          ),
        ),
      );
    } else {
      return Container(); // or any other fallback widget
    }
  }
}

class QuestionTextWithLargeImage extends StatelessWidget {
  final QuestionTextData questionData;

  const QuestionTextWithLargeImage({super.key, required this.questionData});

  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (questionData.hasLargeImage && (questionData.isLargeImageAbove!))
              ImageWidget(
                  imageProvider: questionData.largeImageProvider, height: 150),
            if (questionData.hasQuestionText) Text(questionData.questionText!),
            if (questionData.hasLargeImage &&
                (!questionData.isLargeImageAbove!))
              ImageWidget(
                  imageProvider: questionData.largeImageProvider, height: 150),
          ],
        ),
      ),
    );
  }
}

class DecoratedContainer extends StatelessWidget {
  final Widget? child;

  const DecoratedContainer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
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
      child: child,
    );
  }
}

class ImageWidget extends StatelessWidget {
  final ImageProvider? imageProvider;
  final double? height;

  const ImageWidget({super.key, this.imageProvider, this.height});

  @override
  Widget build(BuildContext context) {
    final ImageProvider defaultImageProvider = height != null && height! < 100
        ? const AssetImage('assets/images/noimage50.png')
        : const AssetImage('assets/images/noimage300.png');

    return Image(
      image: imageProvider ?? defaultImageProvider,
      height: height,
    );
  }
}

class RichTextWidget extends StatelessWidget {
  final List<String> words;
  final int index;
  final ImageProvider? smallImageProvider;

  const RichTextWidget({
    super.key,
    required this.words,
    required this.index,
    this.smallImageProvider,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(text: words.take(index).join(" ")),
          WidgetSpan(
            child: ImageWidget(imageProvider: smallImageProvider, height: 50),
          ),
          TextSpan(text: words.skip(index).join(" ")),
        ],
      ),
    );
  }
}

class QuestionTextData {
  String? questionText;
  ImageProvider? smallImageProvider;
  ImageProvider? largeImageProvider;
  int? smallImageIndex;
  bool? isLargeImageAbove;

  // Getter properties to simplify condition checks
  bool get hasQuestionText => questionText != null;
  bool get hasSmallImage => smallImageProvider != null;
  bool get hasLargeImage => largeImageProvider != null;

  QuestionTextData(
      {this.questionText,
      this.smallImageProvider,
      this.smallImageIndex,
      this.isLargeImageAbove,
      this.largeImageProvider});
}
