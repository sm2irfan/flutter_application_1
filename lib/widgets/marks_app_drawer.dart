import 'package:flutter/material.dart';

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
