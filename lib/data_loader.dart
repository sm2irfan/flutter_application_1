// data_loader.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'data_parser.dart';
import 'question_ground.dart';

class DataLoader {
  static Future<List<QuestionAnswerSetData>> loadDataAndParser(
      String asset) async {
    // Read the JSON data from the external file
    final jsonData = await File(asset).readAsString();
    final ajsonDataTT = json.decode(jsonData);
    // Parse the JSON data
    return parseQuestionAnswerSets(ajsonDataTT);
  }

  static Future<List<dynamic>> loadData(String filePath) async {
  try {
    // Read the JSON data from the file
    final jsonString = await File(filePath).readAsString();

    // Decode the JSON string into a Map<String, dynamic>
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;

    // Get the list of values from the "answerSets" key
    final List<dynamic>? answerSets = jsonData['answerSets'];

    // If the "answerSets" key is not present or is not a list, return an empty list
    return answerSets?.cast<dynamic>() ?? [];
  } catch (e) {
    // Handle errors gracefully
    print('Error loading data: $e');
    return []; // Return an empty list in case of error
  }
}

  static Future<Map<String, dynamic>> readJsonFromAsset(
      String assetPath) async {
    final jsonString =
        await rootBundle.loadString(assetPath); // Load asset as string
    return json.decode(jsonString); // Decode JSON string
  }
}
