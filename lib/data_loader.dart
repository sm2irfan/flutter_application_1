// data_loader.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'data_parser.dart';
import 'question_ground.dart';

class DataLoader {
  static Future<List<QuestionAnswerSetData>> loadData(String asset) async {
    // Read the JSON data from the external file
    final jsonData = await File(asset).readAsString();
    final ajsonDataTT = json.decode(jsonData);

    // Parse the JSON data
    return parseQuestionAnswerSets(ajsonDataTT);
  }

  static Future<Map<String, dynamic>> readJsonFromAsset(String assetPath) async {
    final jsonString = await rootBundle.loadString(assetPath); // Load asset as string
    return json.decode(jsonString); // Decode JSON string
  }
}