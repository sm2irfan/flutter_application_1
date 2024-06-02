// file_utils.dart
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:path/path.dart' as path;

class FileUtils {
  // static count variable
  static int count = 0;
  static bool isFileGetted = false;

  static Future<void> openFile(String filePath) async {
    if (filePath.isEmpty) {
      developer.log("File path is empty, cannot open file");
      return;
    }

    developer.log("Opening file: $filePath");
    try {
      await OpenFile.open(filePath);
      developer.log("File opened successfully");
    } catch (e) {
      developer.log("Error opening file: $e");
    }
  }

  static Future<List<String>> listFilesInDirectory() async {
    // Get the external storage directory
    final externalStorageDirectory = await getExternalStorageDirectory();

    if (externalStorageDirectory == null) {
      developer.log(
          "listFilesInDirectory Function: Unable to get external storage directory");
      return [];
    }

    // Define the subdirectory path
    const questionFolderName = 'assets/question_and_answer_data';
    final targetDirectoryPath =
        path.join(externalStorageDirectory.path, questionFolderName);

    // Ensure the directory exists
    final targetDirectory = Directory(targetDirectoryPath);
    if (!await targetDirectory.exists()) {
      developer.log(
          "listFilesInDirectory Function: Target directory does not exist: $targetDirectoryPath");
      return [];
    }

    // List all entities in the target directory
    final entities = targetDirectory.listSync();

    final List<String> folderPaths = entities
        .whereType<Directory>()
        .map((directory) => directory.path)
        .toList();
    final List<String> filePaths =
        entities.whereType<File>().map((file) => file.path).toList();

    developer.log(
        "listFilesInDirectory Function: listFilesInDirectory: folderPaths: $folderPaths");
    developer.log(
        "listFilesInDirectory Function: listFilesInDirectory: filePaths: $filePaths");

    // Recursively get files from folders
    final List<String> allFilePaths = filePaths;
    for (String folderPath in folderPaths) {
      final folder = Directory(folderPath);
      final folderEntities = folder.listSync();
      final folderFilePaths =
          folderEntities.whereType<File>().map((file) => file.path).toList();
      allFilePaths.addAll(folderFilePaths);
    }

    developer
        .log("listFilesInDirectory Function:: allFilePaths: $allFilePaths");

    return allFilePaths;
  }

  static Future<List<String>> testDateListFilesInDirectory() async {
    try {
      const testDataFolderLocation = 'assets/assets_test/';
      
      // Assuming you want to list files within the folder
      // You might need to create an index of files manually or use a predefined list
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);

      final filePaths = manifestMap.keys
          .where((String key) => key.startsWith(testDataFolderLocation))
          .toList();

      return filePaths;
    } catch (e) {
      developer.log("error $e");
      return Future.error(e);
    }
  }

  static Future<String> copyAssetFileToExternalIfNotExists(
      String assetPath) async {
    try {
      final externalStorageDirectory = await getExternalStorageDirectory();
      if (externalStorageDirectory == null) {
        throw Exception(
            "copyAssetFileToExternalIfNotExists Function: Unable to get external storage directory");
      }

      final externalFilePath =
          path.join(externalStorageDirectory.path, assetPath);
      final externalFile = File(externalFilePath);

      // Create the directory structure if it doesn't exist
      final directoryPath = path.dirname(externalFilePath);
      await Directory(directoryPath).create(recursive: true);

      // Check if the file already exists
      if (await externalFile.exists()) {
        developer.log(
            "copyAssetFileToExternalIfNotExists Function: file already exists: $externalFilePath");
        return externalFilePath;
      }

      // Read the asset file
      final assetData = await rootBundle.load(assetPath);

      // Write the asset data to the external file
      await externalFile.writeAsBytes(assetData.buffer.asUint8List(),
          flush: true);
      developer.log(
          "copyAssetFileToExternalIfNotExists Function: file written to external directory: $externalFilePath");
      return externalFilePath;
    } catch (e) {
      developer.log("copyAssetFileToExternalIfNotExists Function: error: $e");
      return Future.error(e);
    }
  }

  static Future<List<String>> getAssetsFileNames(String folderPath) async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final List<String> assetFileNames = [];

    manifestMap.forEach((String key, dynamic value) {
      if (key.startsWith(folderPath)) {
        assetFileNames.add(key);
      }
    });

    return assetFileNames;
  }

  static Future<void> deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        developer.log('File deleted successfully: $filePath');
      } else {
        developer.log('File does not exist: $filePath');
      }
    } catch (e) {
      developer.log('Error deleting file: $e');
    }
  }
}
