import 'rev_1.dart';

List<QuestionAnswerSetData> parseQuestionAnswerSets(
    Map<String, dynamic> jsonData) {
  final questionAnswerSets = jsonData['questionAnswerSets'] as List;

  return questionAnswerSets.map((questionAnswerSet) {
    final questionTitle = questionAnswerSet['questionTitle'] as String;
    final questionText = questionAnswerSet['questionText'] as String;
    final answerOptions = (questionAnswerSet['answerOptions'] as List)
        .map((answerOption) => AnswerOptionData(
              answerPlace: answerOption['answerPlace'] as String,
              answerText: answerOption['answerText'] as String,
              boxNumber: answerOption['boxNumber'] as double,
            ))
        .toList();

    return QuestionAnswerSetData(
      questionTitle: questionTitle,
      questionText: questionText,
      answerOptions: answerOptions,
    );
  }).toList();
}
