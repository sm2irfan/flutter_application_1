import 'package:flutter/material.dart';

class QuestionTitle extends StatelessWidget {
  final String quesTitle;

  const QuestionTitle({super.key, required this.quesTitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: 40,
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   border: Border.all(
      //     color: Colors.blue,
      //     width: 2,
      //   ),
      //   borderRadius: BorderRadius.circular(8),
      // ),
      child: Padding(
        padding: const EdgeInsets.all(8.0), // adjust the padding as needed
        child: Text(quesTitle),
      ),
      // child: Text(quesTitle),
    );
  }
}

class QuestionText extends StatelessWidget {
  final String quesText;

  const QuestionText({super.key, required this.quesText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.blue,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // adjust the padding as needed
        child: Text(quesText),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
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
    );
  }
}
