import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'question_ground.dart';
// Import the data parser file
import 'file_utils.dart'; // Import the file utilities
import 'data_loader.dart'; // Import the data loader
import 'exam_paper.dart';

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
      routes: {
        '/MyHomePage': (context) => const MyHomePage(title: "test from Rev"),
      },
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
  late List<String> externalStorageFiles = [];
  late List<String> AssetsFiles = [];
  final String _filePath = '';
  late String externalFilePath;

  @override
  void initState() {
    super.initState();
    getAssetsFileNamesAndCopy();
  }

  // the initializeAssets method is being called indirectly
  // through the FutureBuilder widget in the build method.
  Future<List<String>> initializeAssets() async {
    final externalStorageFiles =
        await FileUtils.listFilesInDirectory();
    // externalStorageFiles.forEach((element) {
    //   FileUtils.deleteFile(element);
    // });

    return externalStorageFiles;
  }

  Future<List<String>> getAssetsFileNamesAndCopy() async {
    print('from getAssetsFileNamesAndCopy');
    final files = await FileUtils.getAssetsFileNames('assets/');
    for (var element in files) {
      FileUtils.copyAssetFileToExternalIfNotExists(element);
    }
    return files;
  }

  // Load the data asynchronously
  Future<void> _loadData(String asset) async {
    final currentContext = context;
    setState(() {
      isLoading = true;
    });

    // Use the DataLoader class to load the data
    questionAnswerSetDataList = await DataLoader.loadDataAndParser(asset);

    setState(() {
      isLoading = false;
    });

    // Navigate to the second screen using a named route.
    MaterialPageRoute route = MaterialPageRoute(
      builder: (currentContext) => QuestionGround(
        filePath: asset,
        title: 'from first',
        questionAnswerSetDataList: questionAnswerSetDataList,
      ),
    );
    Navigator.push(currentContext, route);
  }

  Future<void> openFile(String filePath) async {
    // Use the FileUtils class to open the file
    await FileUtils.openFile(filePath);
  }

  // Future<List<String>> listFilesInDirectory() async {
  //   // Get the external storage directory
  //   final directory = await getExternalStorageDirectory();
  //   if (directory == null) {
  //     print("External storage directory not found.");
  //     return [];
  //   }

  //   final List<FileSystemEntity> files = directory.listSync();
  //   final List<String> filePaths = files.map((file) => file.path).toList();
  //   return filePaths;
  // }

  void handleEdit(String asset) {
    print('Editing handleEdit');
    // Implement the logic for editing the asset
    openFile(asset);
    print('Editing asset: $asset');
  }

  void handleReset(String asset) {
    // Implement the logic for resetting the asset
    print('Resetting asset: $asset');
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
        child: FutureBuilder<List<String>>(
          future: initializeAssets(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Show loading indicator
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // Show error message
            } else {
              // Assets loaded successfully
              externalStorageFiles = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (var asset in externalStorageFiles)
                      Padding(
                        padding: const EdgeInsets.all(
                            8.0), // Add vertical spacing of 8 units
                        child: ExamPaper(
                          buttonText:
                              'கடந்த கால வினாக்கள் 2023, இரண்டு மணித்தியால வினாக்கள்',
                          onPressed: () => _loadData(asset),
                          isLoading: isLoading,
                          onEditPressed: () => handleEdit(asset),
                          onResetPressed: () => handleReset(asset),
                        ),
                      ),
                  ],
                ),
              );
            }
          },
        ),
      ),
      drawer: const Drawer(
        // Add a drawer here
        child: Column(children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text('irfan'),
              accountEmail: Text("irfan@gmail"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  'hi ',
                ),
              )),
          ListTile(
            title: Text("pass peper"),
            leading: Icon(Icons.check),
          ),
          Divider(
            height: 5,
          ),
          ListTile(
            title: Text("pass peper 2"),
            leading: Icon(Icons.check),
          ),
          Divider(
            height: 5,
          )
        ]),
      ),
    );
  }
}
