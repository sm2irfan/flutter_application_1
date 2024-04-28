import 'package:flutter/material.dart';

class AnswerOption extends StatelessWidget {
  final String answerPlace;
  final AnswerTextData answerTextData;
  final Color color;
  final VoidCallback onTap;

  const AnswerOption({
    super.key,
    required this.answerPlace,
    required this.answerTextData,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.blue, width: 1),
        ),
        child: ListTile(
          title: answerTextCondition(),
          leading: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                answerPlace,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget answerTextCondition() {
    return ConditionalAnswerText(answerTextData: answerTextData);
  }
}

class ConditionalAnswerText extends StatelessWidget {
  final AnswerTextData answerTextData;

  const ConditionalAnswerText({super.key, required this.answerTextData});

  @override
  Widget build(BuildContext context) {
    final List<String> words = answerTextData.answerText?.split(" ") ?? [];
    const int smallImageIndex = 0;
    ImageProvider smallImageProvider = answerTextData.smallImageProvider ??
        const AssetImage('assets/images/noImage50.png');
    ImageProvider mediumImageProvider = answerTextData.mediumImageProvider ??
        const AssetImage('assets/images/noImage150.png');
    if (answerTextData.hasAnswerText &&
        answerTextData.hasMediumImage &&
        answerTextData.hasSmallImage) {
      return richTextWidgetWithImage(
          words, smallImageIndex, smallImageProvider, mediumImageProvider);
    } else if (answerTextData.hasAnswerText && answerTextData.hasMediumImage) {
      return answerWithMediumImage(mediumImageProvider);
    } else if (answerTextData.hasAnswerText && answerTextData.hasSmallImage) {
      return RichTextWidget(
        words: words,
        index: smallImageIndex,
        smallImageProvider: smallImageProvider,
      );
    } else if (answerTextData.hasMediumImage) {
      return ImageWidget(imageProvider: mediumImageProvider, height: 80);
    } else {
      return textOnly();
    }
  }

  Column answerWithMediumImage(imageProvider) {
    return Column(
      children: [
        ImageWidget(imageProvider: imageProvider, height: 80),
        Text(
          answerTextData.answerText ?? '',
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );
  }

  Text textOnly() {
    return Text(
      answerTextData.answerText ?? '',
      style: const TextStyle(color: Colors.black),
    );
  }

  Widget richTextWidgetWithImage(
      words, smallImageIndex, smallImageProvider, mediumImageProvider) {
    return Column(children: [
      ImageWidget(imageProvider: mediumImageProvider, height: 80),
      RichTextWidget(
          words: words,
          index: smallImageIndex,
          smallImageProvider: smallImageProvider),
    ]);
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

class ImageWidget extends StatelessWidget {
  final ImageProvider? imageProvider;
  final double? height;

  const ImageWidget({super.key, this.imageProvider, this.height});

  @override
  Widget build(BuildContext context) {
    final ImageProvider defaultImageProvider = height != null && height! < 100
        ? const AssetImage('assets/images/noImage50.png')
        : const AssetImage('assets/images/noImage150.png');

    return Image(
      image: imageProvider ?? defaultImageProvider,
      height: height,
    );
  }
}

class AnswerTextData {
  String? answerText;
  ImageProvider? smallImageProvider;
  ImageProvider? mediumImageProvider;
  int? smallImageIndex;

  // Getter properties to simplify condition checks
  bool get hasAnswerText => answerText != null;
  bool get hasSmallImage => smallImageProvider != null;
  bool get hasMediumImage => mediumImageProvider != null;

  AnswerTextData(
      {this.answerText,
      this.smallImageProvider,
      this.smallImageIndex,
      this.mediumImageProvider});
}
