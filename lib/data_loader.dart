// data_loader.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'data_parser.dart';
import 'dart:developer' as developer;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DataLoader {
  
  static bool isTestingRun = dotenv.env['isTestingRun']?.toLowerCase() == 'true';
  static Future<List<dynamic>> loadDataAndParser(String asset) async {
    final dynamic jsonString;
    try {
      if (isTestingRun) {
        // const questionPath = "assets/assets_test/data.json";
        jsonString = await rootBundle.loadString(asset);
      } else {
        developer.log('Loading data from $asset');
        jsonString = await File(asset).readAsString();
      }
    } catch (e) {
      // Handle the error, e.g., log it or throw a custom exception
      developer.log('Error loading data: $e');
      throw FormatException('Failed to load data from $asset');
    }

    final data = json.decode(jsonString) as Map<String, dynamic>;
    return parseQuestionAnswerSets(data);
  }

  static Future<List<dynamic>> loadDataAnswerSheet(String filePath) async {
    final dynamic jsonString;

    try {
      if (isTestingRun) {
        // const answerPath = "assets/question_and_answer_data/data_answer.json";
        const answerPath = "assets/assets_test/data_answer.json";
        jsonString =
            await rootBundle.loadString(answerPath); // Load asset as string
      } else {
        // Read the JSON data from the file
        jsonString = await File(filePath).readAsString();
      }

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
