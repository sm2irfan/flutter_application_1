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
          title: _buildAnswerTextCondition(context),
          leading: _buildLeadingContainer(answerPlace),
        ),
      ),
    );
  }

  Widget _buildAnswerTextCondition(BuildContext context) {
    return ConditionalAnswerText(
      answerTextData: answerTextData,
      defaultTextStyle: DefaultTextStyle.of(context).style,
    );
  }

  Widget _buildLeadingContainer(String answerPlace) {
    return SizedBox(
      width: 30,
      height: 30,
      child: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(
          answerPlace,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class ConditionalAnswerText extends StatelessWidget {
  final AnswerTextData answerTextData;
  final TextStyle defaultTextStyle;

  const ConditionalAnswerText({
    super.key,
    required this.answerTextData,
    required this.defaultTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> words = answerTextData.answerText?.split(" ") ?? [];
    final int smallImageIndex = answerTextData.smallImageIndex ?? 0;
    final ImageProvider smallImageProvider =
        answerTextData.smallImageProvider ??
            const AssetImage('assets/images/noImage50.png');
    final ImageProvider mediumImageProvider =
        answerTextData.mediumImageProvider ??
            const AssetImage('assets/images/noImage150.png');

    if (answerTextData.hasAnswerText &&
        answerTextData.hasMediumImage &&
        answerTextData.hasSmallImage) {
      return _buildRichTextWidgetWithImage(
        words,
        smallImageIndex,
        smallImageProvider,
        mediumImageProvider,
      );
    } else if (answerTextData.hasAnswerText && answerTextData.hasMediumImage) {
      return _buildAnswerWithMediumImage(mediumImageProvider);
    } else if (answerTextData.hasAnswerText && answerTextData.hasSmallImage) {
      return RichTextWidget(
        words: words,
        index: smallImageIndex,
        smallImageProvider: smallImageProvider,
        defaultTextStyle: defaultTextStyle,
      );
    } else if (answerTextData.hasMediumImage) {
      return Padding(
        padding: const EdgeInsets.only(
            left: 16.0), // Adjust the padding value as needed
        child: Align(
          alignment: Alignment.centerLeft,
          child: ImageWidget(imageProvider: mediumImageProvider, height: 80),
        ),
      );
    } else {
      return _buildTextOnly();
    }
  }

  Column _buildAnswerWithMediumImage(ImageProvider imageProvider) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageWidget(imageProvider: imageProvider, height: 80),
        Text(
          answerTextData.answerText ?? '',
          style: defaultTextStyle.copyWith(color: Colors.black),
        ),
      ],
    );
  }

  Text _buildTextOnly() {
    return Text(
      answerTextData.answerText ?? '',
      style: defaultTextStyle.copyWith(color: Colors.black),
    );
  }

  Widget _buildRichTextWidgetWithImage(
    List<String> words,
    int smallImageIndex,
    ImageProvider smallImageProvider,
    ImageProvider mediumImageProvider,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageWidget(imageProvider: mediumImageProvider, height: 80),
        RichTextWidget(
          words: words,
          index: smallImageIndex,
          smallImageProvider: smallImageProvider,
          defaultTextStyle: defaultTextStyle,
        ),
      ],
    );
  }
}

class RichTextWidget extends StatelessWidget {
  final List<String> words;
  final int index;
  final ImageProvider? smallImageProvider;
  final TextStyle defaultTextStyle;

  const RichTextWidget({
    super.key,
    required this.words,
    required this.index,
    this.smallImageProvider,
    required this.defaultTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: defaultTextStyle,
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
      fit: BoxFit.contain,
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

  AnswerTextData({
    this.answerText,
    this.smallImageProvider,
    this.smallImageIndex,
    this.mediumImageProvider,
  });
}
