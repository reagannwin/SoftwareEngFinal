import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:goobers_final/main.dart';
import 'package:goobers_final/videoPage.dart';


import 'dart:core';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          //error check
          if (snapshot.hasError){
            print("Couldn't connect");
          }
          //show app
          if (snapshot.connectionState == ConnectionState.done){

            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const VideoPage(title: 'VideoTest',),
            );
          }
          Widget loading = MaterialApp();
          return loading;
        });

  }

}