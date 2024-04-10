import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'rev_1.dart';
import 'data_parser.dart'; // Import the data parser file
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "test from Rev"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<QuestionAnswerSetData> questionAnswerSetDataList;
  late bool isLoading = false;
  late List<String> assetFiles = [
    'assets/data.json',
    'assets/dataForSecond.json',
  ];
  String _filePath = '';
  late String externalFilePath;
  // Load the data asynchronously
  Future<void> _loadData(String asset) async {
    final currentContext = context;
    setState(() {
      isLoading = true;
    });
    // Read the JSON data from the external file
    final jsonData = await File(asset).readAsString();
    final ajsonDataTT = json.decode(jsonData);

    // final ajsonDataTT = await readJsonFromAsset(asset);
    questionAnswerSetDataList = parseQuestionAnswerSets(ajsonDataTT);
    setState(() {
      isLoading = false;
    });

    // Navigate to the second screen using a named route.
    MaterialPageRoute route = MaterialPageRoute(
      builder: (currentContext) => RevHome(
        title: 'from first',
        questionAnswerSetDataList: questionAnswerSetDataList,
      ),
    );
    Navigator.push(currentContext, route);
  }

  Future<void> _saveToFile() async {
    const String content = 'Hi this is for test new i am ithaar';

    await Permission.storage.request();

    // Get the external storage directory
    final directory = await getExternalStorageDirectory();

    final String filePath = '${directory?.path}/myy_file.txt';

    print("filepath: $filePath");

    // Write to the file
    final File file = File(filePath);
    await file.writeAsString(content);

    setState(() {
      _filePath = filePath;
    });
  }

  Future<void> openFile() async {
    final filePath = _filePath; // Assuming _filePath is the path to your file

    if (filePath != null) {
      print("file path: $filePath");
      await OpenFile.open(filePath);
    }
  }

  Future<void> openFileaa(String filePath) async {
    if (filePath.isNotEmpty) {
      print("Opening file: $filePath");
      await OpenFile.open(filePath);
    }
  }

  Future<String> _copyAssetFileToExternal(String assetPath) async {
    // Request storage permission
    await Permission.storage.request();

    // Get the external storage directory
    final directory = await getExternalStorageDirectory();

    // Create a new file in the external storage directory
    final String filePath = '${directory!.path}/${assetPath.split('/').last}';

    // Read the asset file
    final assetData = await rootBundle.load(assetPath);

    // Write the asset data to the external file
    final externalFile = File(filePath);
    await externalFile.writeAsBytes(assetData.buffer.asUint8List(),
        flush: true);

    print("External file path: $filePath");

    return filePath;
  }

  Future<Map<String, dynamic>> readJsonFromAsset(String assetPath) async {
    final jsonString =
        await rootBundle.loadString(assetPath); // Load asset as string
    return json.decode(jsonString); // Decode JSON string
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Set your desired background color here
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (var asset in assetFiles)
              ElevatedButton(
                onPressed: isLoading
                    ? null // Disable button if data is loading
                    : () => _loadData(externalFilePath), // Load data on button press
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 197, 219, 236), // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 30), // Button padding
                ),
                child: Text(
                  'fiele name: $asset', // Text to display in the button asset
                  style: const TextStyle(
                      fontSize: 12, color: Colors.black), // Text style
                ),
              ),
            ElevatedButton(
              onPressed: _saveToFile,
              child: Text('Save File'),
            ),
            ElevatedButton(
              onPressed: openFile,
              child: Text('Open File'),
            ),
            ElevatedButton(
              onPressed: () async {
                externalFilePath =
                    await _copyAssetFileToExternal('assets/dataForSecond.json');
              },
              child: Text('Save dataForSecond.json'),
            ),
            ElevatedButton(
              onPressed: () async {
                await openFileaa(externalFilePath);
              },
              child: Text('Open dataForSecond.json'),
            ),
            if (isLoading) // Display circular progress indicator when loading
              const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
