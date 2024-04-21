import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/question_text.dart';

import 'single_question_answer_set.dart';
import 'dart:developer' as developer;

List<QuestionAnswerSetData> parseQuestionAnswerSets(
    Map<String, dynamic> jsonData) {
  try {
    final questionAnswerSets = jsonData['questionAnswerSets'] as List? ?? [];
    return questionAnswerSets.map((questionAnswerSet) {
      final questionTitle = questionAnswerSet['questionTitle'] as String;
      final questionTextJson = questionAnswerSet['questionText'];
      final String? imagePath = questionTextJson['imageProviderUrl'] as String?;
      final questionText = QuestionTextData(
        quesText: questionTextJson['quesText'] as String,
        imageProvider: imagePath != null ? AssetImage(imagePath) : null,
        spaceCount: questionTextJson['spaceCount'] as int?,
      );
      final answerOptions = (questionAnswerSet['answerOptions'] as List)
          .map((answerOption) => AnswerOptionData(
                answerPlace: answerOption['answerPlace'] as String,
                answerText: answerOption['answerText'] as String,
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
