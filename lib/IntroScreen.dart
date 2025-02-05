import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'LogIn.dart';
import 'SignUp.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Center(
              child: Column(
            children: [
              Padding(padding: EdgeInsets.all(50)),
            ElevatedButton(
            child: Text("Sign Up"),
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp()));
        },
      ),
      Padding(padding: EdgeInsets.all(20)),
      ElevatedButton(onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogIn()));
      }, child: Text("Log In"))
          ],
        )

            )
          ],
        ),
      ),
    );
  }
}