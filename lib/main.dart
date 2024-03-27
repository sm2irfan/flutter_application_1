import 'package:flutter/material.dart';
import 'rev_1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  int _counter = 0;
  int selectedBox = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Color getBoxColor(int boxNumber) {
    switch (boxNumber) {
      case 1:
        return selectedBox == boxNumber ? Colors.red : Colors.white;
      case 2:
        return selectedBox == boxNumber ? Colors.yellow : Colors.white;
      case 3:
        return selectedBox == boxNumber ? Colors.black : Colors.white;
      default:
        return Colors.white;
    }
  }

  void selectBox(int boxNumber) {
    setState(() {
      selectedBox = boxNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.blue, // Set your desired background color here
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.menu),
        //   onPressed: () => {
        //     print("icon clicked")
        //   },
        // ),
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        // a
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectBox(1);
                    },
                    child: Container(
                      color: getBoxColor(1),
                      height: 100,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectBox(2);
                    },
                    child: Container(
                      color: getBoxColor(2),
                      height: 100,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectBox(3);
                    },
                    child: Container(
                      color: getBoxColor(3),
                      height: 100,
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              'You have pushed the button this many times vee:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      drawer: const Drawer(
        elevation: 16.0,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("irfan"),
              accountEmail: Text("irfan@gmail"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text("Hi"),
              ),
            ),
            ListTile(
              title: Text("1 marks : 78"),
              leading: Icon(Icons.check),
            ),
            ListTile(
              title: Text("2 marks : 82"),
              leading: Icon(Icons.check),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
