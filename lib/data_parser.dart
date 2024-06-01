import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mcqapp/widgets/answer_option.dart';
import 'package:mcqapp/widgets/question_text.dart';
import 'package:path_provider/path_provider.dart';
import 'single_question_answer_set.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_dotenv/flutter_dotenv.dart';

bool isImagePathFromAsset = dotenv.env['isTestingRun']?.toLowerCase() == 'true';

Future<String> getTargetDirectoryPath() async {
  final externalStorageDirectory = await getExternalStorageDirectory();
  const questionFolderName = 'assets/question_and_answer_data';
  return path.join(externalStorageDirectory!.path, questionFolderName);
}

Future<List<dynamic>> parseQuestionAnswerSets(Map<String, dynamic> jsonData) async {
  try {
    final questionAnswerSets = jsonData['questionAnswerSets'] as List<dynamic>?;
    return questionAnswerSets != null
        ? await Future.wait(questionAnswerSets.cast<Map<String, dynamic>>().map(_parseQuestionOrDescription).toList())
        : [];
  } catch (e) {
    developer.log('Error parsing JSON data: $e');
    return [];
  }
}

Future<dynamic> _parseQuestionOrDescription(Map<String, dynamic> questionData) async {
  if (questionData.containsKey('questionDescription')) {
    return questionData['questionDescription'] as String;
  } else {
    return await _parseQuestionAnswerSet(questionData);
  }
}

Future<QuestionAnswerSetData> _parseQuestionAnswerSet(Map<String, dynamic> questionAnswerSet) async {
  final questionTitle = questionAnswerSet['questionTitle'] as String;
  final questionTextData = await _parseQuestionTextData(questionAnswerSet['questionTextData']);
  final answerOptions = await _parseAnswerOptions(questionAnswerSet['answerOptions'] as List<dynamic>);

  return QuestionAnswerSetData(
    questionTitle: questionTitle,
    questionText: questionTextData,
    answerOptions: answerOptions,
  );
}

Future<QuestionTextData> _parseQuestionTextData(Map<String, dynamic> questionTextJson) async {
  final imagePath = questionTextJson['smallImageProvider'] as String?;
  final largeImagePath = questionTextJson['largeImageProvider'] as String?;
  final isLargePicAbove = questionTextJson['isLargeImageAbove'] as bool?;
  final quesText = questionTextJson['questionText'] as String?;

  return QuestionTextData(
    questionText: quesText,
    smallImageProvider: await _getImageProvider(imagePath),
    smallImageIndex: questionTextJson['smallImageIndex'] as int?,
    isLargeImageAbove: isLargePicAbove,
    largeImageProvider: await _getImageProvider(largeImagePath),
  );
}

Future<ImageProvider<Object>?> _getImageProvider(String? imagePath) async {
  if (imagePath == null) {
    developer.log('Attempting to get image provider for null image path');
    return null;
  }
  
  if (isImagePathFromAsset) {
    // add "assets/" to the image path
    // imagePath = 'assets/$imagePath';
    return AssetImage(imagePath) as ImageProvider<Object>;
  }
  
  final targetDirectoryPath = await getTargetDirectoryPath();
  final joinPath = path.join(targetDirectoryPath, imagePath);

  developer.log('Attempting to get image provider for $imagePath');
  developer.log('Target directory path is $targetDirectoryPath');
  developer.log('Join path is $joinPath');

  return FileImage(File(joinPath)) as ImageProvider<Object>;
}

Future<List<AnswerOptionData>> _parseAnswerOptions(List<dynamic> answerOptions) async {
  return Future.wait(answerOptions.map((answerOption) async {
    return AnswerOptionData(
      answerPlace: answerOption['answerPlace'] as String,
      answerTextData: await _parseAnswerTextData(answerOption['answerTextData']),
      boxNumber: answerOption['boxNumber'] as String,
    );
  }).toList());
}

Future<AnswerTextData> _parseAnswerTextData(Map<String, dynamic> answerTextData) async {
  return AnswerTextData(
    answerText: answerTextData['answerText'] as String?,
    mediumImageProvider: await _getImageProvider(answerTextData['mediumImageProvider'] as String?),
    smallImageProvider: await _getImageProvider(answerTextData['smallImageProvider'] as String?),
    smallImageIndex: answerTextData['smallImageIndex'] as int?,
  );
}
