import 'question_ground.dart';
List<QuestionAnswerSetData> parseQuestionAnswerSets(Map<String, dynamic> jsonData) {
  try {
    final questionAnswerSets = jsonData['questionAnswerSets'] as List? ?? [];
    return questionAnswerSets.map((questionAnswerSet) {
      final questionTitle = questionAnswerSet['questionTitle'] as String;
      final questionText = questionAnswerSet['questionText'] as String;
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
    print('Error parsing JSON data: $e');
    return []; // Return an empty list if there's an issue with the JSON data
  }
}