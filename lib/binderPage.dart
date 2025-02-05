import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'videoPage.dart';
import 'bookPage.dart';
import 'homePage.dart';

class BinderPage extends StatefulWidget {
  const BinderPage({super.key, required this.title, this.uid});

  final String? uid;
  final String title;

  @override
  State<BinderPage> createState() => _BinderPageState();
}

class _BinderPageState extends State<BinderPage> {
  int _selectedIndex = 0;
  User? user = FirebaseAuth.instance.currentUser;
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    BookPage(title: 'Books'),
    VideoPage(title: 'Videos'),
  ];

  List<String> pageNames = <String>[
    "Home Page",
    "Books",
    "Videos"
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pageNames[_selectedIndex],
       // style: TextStyle(color: Colors.black),
      ),
        backgroundColor: Colors.purple[200]!,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height:125.0,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple[200],
              ),
              child: Text('Navigation Menu', style: TextStyle(fontSize: 20.0)),
            ),
            ),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Books'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Videos'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}