import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mcqapp/widgets/answer_option.dart';
import 'package:mcqapp/widgets/question_text.dart';
import 'single_question_answer_set.dart';

var isImagePathFromAsset = false;

List<dynamic> parseQuestionAnswerSets(Map<String, dynamic> jsonData) {
  try {
    if (jsonData['questionAnswerSets'] != null) {
      final questionAnswerSets =
          (jsonData['questionAnswerSets'] as List).cast<Map<String, dynamic>>();
      return questionAnswerSets.map(_parseQuestionOrDescription).toList();
    } else {
      return [];
    }
  } catch (e) {
    developer.log('Error parsing JSON data: $e');
    return []; // Return an empty list if there's an issue with the JSON data
  }
}

dynamic _parseQuestionOrDescription(Map<String, dynamic> questionData) {
  if (questionData.containsKey('questionDescription')) {
    return questionData['questionDescription'] as String;
  } else {
    return _parseQuestionAnswerSet(questionData);
  }
}

QuestionAnswerSetData _parseQuestionAnswerSet(
    Map<String, dynamic> questionAnswerSet) {
  final questionTitle = questionAnswerSet['questionTitle'] as String;
  final questionTextData =
      _parseQuestionTextData(questionAnswerSet['questionTextData']);
  final answerOptions =
      _parseAnswerOptions(questionAnswerSet['answerOptions'] as List);

  return QuestionAnswerSetData(
    questionTitle: questionTitle,
    questionText: questionTextData,
    answerOptions: answerOptions,
  );
}

QuestionTextData _parseQuestionTextData(Map<String, dynamic> questionTextJson) {
  final String? imagePath = questionTextJson['smallImageProvider'] as String?;
  final String? largeImagePath =
      questionTextJson['largeImageProvider'] as String?;
  final bool? isLargePicAbove = questionTextJson['isLargeImageAbove'] as bool?;
  final String? quesText = questionTextJson['questionText'] as String?;

  return QuestionTextData(
    questionText: quesText,
    smallImageProvider: imagePath != null
        ? (isImagePathFromAsset ? AssetImage(imagePath) as ImageProvider<Object> : FileImage(File(imagePath)) as ImageProvider<Object>)
        : null,
    smallImageIndex: questionTextJson['smallImageIndex'] as int?,
    isLargeImageAbove: isLargePicAbove,
    largeImageProvider: largeImagePath != null
        ? (isImagePathFromAsset ? AssetImage(largeImagePath) as ImageProvider<Object> : FileImage(File(largeImagePath)) as ImageProvider<Object>)
        : null,
  );
}

List<AnswerOptionData> _parseAnswerOptions(List<dynamic> answerOptions) {
  return answerOptions.map((answerOption) {
    return AnswerOptionData(
      answerPlace: answerOption['answerPlace'] as String,
      answerTextData: _parseAnswerTextData(answerOption['answerTextData']),
      boxNumber: answerOption['boxNumber'] as String,
    );
  }).toList();
}

AnswerTextData _parseAnswerTextData(Map<String, dynamic> answerTextData) {
  return AnswerTextData(
    answerText: answerTextData['answerText'] as String?,
    mediumImageProvider: answerTextData['mediumImageProvider'] != null
        ? (isImagePathFromAsset
            ? AssetImage(answerTextData['mediumImageProvider'] as String) as ImageProvider<Object>
            : FileImage(File(answerTextData['mediumImageProvider'] as String)) as ImageProvider<Object>)
        : null,
    smallImageProvider: answerTextData['smallImageProvider'] != null
        ? (isImagePathFromAsset
            ? AssetImage(answerTextData['smallImageProvider'] as String) as ImageProvider<Object>
            : FileImage(File(answerTextData['smallImageProvider'] as String)) as ImageProvider<Object>)
        : null,
    smallImageIndex: answerTextData['smallImageIndex'] as int?,
  );
}