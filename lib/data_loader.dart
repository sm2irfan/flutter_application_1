// data_loader.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'data_parser.dart';
import 'single_question_answer_set.dart';
import 'dart:developer' as developer;

class DataLoader {
  static Future<List<QuestionAnswerSetData>> loadDataAndParser(
      String asset) async {
    developer.log('Loading data from $asset'); // Log the file being loaded
    final jsonData = await File(asset).readAsString();
    final ajsonDataTT = json.decode(jsonData);
    return parseQuestionAnswerSets(
        ajsonDataTT); // Parse and return the JSON data
  }

  static Future<List<dynamic>> loadDataAnswerSheet(String filePath) async {
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
      developer.log('Error loading data: $e');
      return []; // Return an empty list in case of error
    }
  }

  static Future<Map<String, dynamic>> readJsonFromAsset(
      String assetPath) async {
    /*  This method is used to asynchronously load a string of text 
    from an asset bundle. The assetPath is the path to the asset 
    within your project's asset folder as defined in the pubspec.
    yaml file. It's typically used to load configuration files, 
    JSON data, or other text-based assets into your app.*/
    final jsonString =
        await rootBundle.loadString(assetPath); // Load asset as string
    return json.decode(jsonString); // Decode JSON string
  }
}
