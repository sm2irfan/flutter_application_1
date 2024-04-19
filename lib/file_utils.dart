// file_utils.dart
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';

class FileUtils {
  // static count variable
  static int count = 0;
  static bool isFileGetted = false;

  static Future<void> openFile(String filePath) async {
    if (filePath.isNotEmpty) {
      print("Opening file: $filePath");
      await OpenFile.open(filePath);
    }
  }

  static Future<List<String>> listFilesInDirectory() async {
    // Get the external storage directory
    final directory = await getExternalStorageDirectory();
    if (directory == null) {
      print("External storage directory not found.");
      return [];
    }

    final List<FileSystemEntity> files = directory.listSync();
    List<String> filePaths = [];
    filePaths = files
        .map((file) => file.path)
        .where((path) => !path.contains('_answer'))
        .toList();

    for (var element in filePaths) {
      print(element);
    }
    // isFileGetted = true;
    return filePaths;
  }

  static Future<String> copyAssetFileToExternalIfNotExists(
      String assetPath) async {
    // Request storage permission
    await Permission.storage.request();

    // Get the external storage directory
    final directory = await getExternalStorageDirectory();

    // Create a new file path in the external storage directory
    final String filePath = '${directory!.path}/${assetPath.split('/').last}';

    // Check if the file already exists
    final File copiedFile = File(filePath);
    if (await copiedFile.exists()) {
      print("File already exists at: $filePath");
      return filePath;
    }

    // Read the asset file
    final assetData = await rootBundle.load(assetPath);

    // Write the asset data to the external file
    await copiedFile.writeAsBytes(assetData.buffer.asUint8List(), flush: true);

    print("External file copied to: $filePath");

    return filePath;
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
        print('File deleted successfully: $filePath');
      } else {
        print('File does not exist: $filePath');
      }
    } catch (e) {
      print('Error deleting file: $e');
    }
  }
}
