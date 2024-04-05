import 'package:flutter/material.dart';
import 'rev_1.dart';
import 'assets/data.dart'; // Import the data file
import 'data_parser.dart'; // Import the data parser file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<QuestionAnswerSetData> questionAnswerSetDataList;

  @override
  void initState() {
    super.initState();
    // Parse the JSON data and initialize the questionAnswerSetDataList
    questionAnswerSetDataList = parseQuestionAnswerSets(jsonData);
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
            ElevatedButton(
              onPressed: () {
                // Navigate to the second screen using a named route.
                MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => RevHome(
                          title: 'from first',
                          questionAnswerSetDataList: questionAnswerSetDataList,
                        ));
                Navigator.push(context, route);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                    255, 197, 219, 236), // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 15, horizontal: 30), // Button padding
              ),
              child: const Text(
                "In the provided code, this error is likely originating from the ElevatedButton.styleFrom method where you're trying to set the primary color. However, there's no parameter named primary in ElevatedButton.styleFrom.", // Text for the button
                style:
                    TextStyle(fontSize: 12, color: Colors.black), // Text style
              ),
            ),
            const SizedBox(height: 20), // Spacer between buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to the second screen using a named route.
                MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => RevHome(
                          title: 'from first',
                          questionAnswerSetDataList: questionAnswerSetDataList,
                        ));
                Navigator.push(context, route);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                    255, 172, 210, 241), // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 15, horizontal: 30), // Button padding
              ),
              child: const Text(
                "First Question In the provided code, this error is likely originating from the ElevatedButton.styleFrom method where you're trying to set the primary color. However, there's no parameter named primary in ElevatedButton.styleFrom.", // Text for the button
                style:
                    TextStyle(fontSize: 12, color: Colors.black), // Text style
              ),
            )
          ],
        ),
      ),
    );
  }
}
