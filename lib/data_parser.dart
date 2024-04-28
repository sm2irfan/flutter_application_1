import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/answer_option.dart';
import 'package:flutter_application_1/widgets/question_text.dart';

import 'single_question_answer_set.dart';
import 'dart:developer' as developer;

List<QuestionAnswerSetData> parseQuestionAnswerSets(
    Map<String, dynamic> jsonData) {
  try {
    final questionAnswerSets = jsonData['questionAnswerSets'] as List? ?? [];
    return questionAnswerSets.map((questionAnswerSet) {
      final questionTitle = questionAnswerSet['questionTitle'] as String;
      final questionTextJson = questionAnswerSet['questionTextData'];
      final String? imagePath =
          questionTextJson['smallImageProvider'] as String?;
      final String? largeImagePath =
          questionTextJson['largeImageProvider'] as String?;
      final bool? islargePicAbove =
          questionTextJson['isLargeImageAbove'] as bool?;
      final String? quesText = questionTextJson['questionText'] as String?;
      final questionText = QuestionTextData(
        questionText: quesText,
        smallImageProvider: imagePath != null ? AssetImage(imagePath) : null,
        smallImageIndex: questionTextJson['smallImageIndex'] as int?,
        isLargeImageAbove: islargePicAbove,
        largeImageProvider:
            largeImagePath != null ? AssetImage(largeImagePath) : null,
      );
      final answerOptions = (questionAnswerSet['answerOptions'] as List)
          .map((answerOption) => AnswerOptionData(
                answerPlace: answerOption['answerPlace'] as String,
                answerTextData: AnswerTextData(
                  answerText:
                      answerOption['answerTextData']['answerText'] as String?,
                  mediumImageProvider: answerOption['answerTextData']
                              ['mediumImageProvider'] !=
                          null
                      ? AssetImage(answerOption['answerTextData']
                          ['mediumImageProvider'] as String)
                      : null,
                ),
                boxNumber: answerOption['boxNumber'] as String,
              ))
          .toList();
      return QuestionAnswerSetData(
        questionTitle: questionTitle,
        questionText: questionText,
        answerOptions: answerOptions,
      );
    }).toList();
  } catch (e) {
    developer.log('Error parsing JSON data: $e');
    return []; // Return an empty list if there's an issue with the JSON data
  }
}
