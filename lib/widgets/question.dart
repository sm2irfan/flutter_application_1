import 'package:flutter/material.dart';

class QuestionTitle extends StatelessWidget {
  const QuestionTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.blue,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class QuestionText extends StatelessWidget {
  const QuestionText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.blue,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
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
