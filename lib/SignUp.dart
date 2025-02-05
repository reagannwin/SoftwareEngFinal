import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'IntroScreen.dart';
import 'databaseHandler.dart';
import 'binderPage.dart';

//import 'package:intl/intl.dart';

import 'IntroScreen.dart';
import 'main.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // DatabaseReference dbRef =
  // FirebaseDatabase.instance.ref().child("Users");
  CollectionReference<Map<String, dynamic>>? databaseReference =
  FirebaseFirestore.instance.collection('Users');
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign Up", style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => IntroScreen()));
            },
          ),
          backgroundColor: Colors.purple[200],
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Enter User Name",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter User Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Enter Email",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter an Email Address';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(20.0),
                    // child: TextFormField(
                    //   controller: ageController,
                    //   decoration: InputDecoration(
                    //     labelText: "Enter Age",
                    //     enabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10.0),
                    //     ),
                    //   ),
                    //   // The validator receives the text that the user has entered.
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Enter Age';
                    //     }
                    //     return null;
                    //   },
                    // ),
                  //),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Enter Password",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.purple[200]!)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          registerToFb();
                        }
                      },
                      child: Text('Submit', style: TextStyle(color: Colors.black),),
                    ),
                  )
                ]))));
  }

  void registerToFb() {
    firebaseAuth
        .createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text)
        .then((result) {

      databaseHandler userFavoritesInitialization = databaseHandler(FirebaseFirestore.instance.collection(
          'Users').doc(result.user!.uid).collection('Book List'));
      userFavoritesInitialization.inputNumber = '-1';
      userFavoritesInitialization.createBook();
      //
      // journalHandler userJournalsInitialization = journalHandler(FirebaseFirestore.instance.collection(
      //     'Users').doc(result.user!.uid).collection('Journals'));
      // String inputDate = DateFormat.yMMMd().format(DateTime.now()).toString();
      // userJournalsInitialization.inputDate = inputDate;
      // userJournalsInitialization.createJournal();
      //
      // databaseHandler userActivitiesInitialization = databaseHandler(FirebaseFirestore.instance.collection(
      //     'Users').doc(result.user!.uid).collection('Activities'));
      // userActivitiesInitialization.inputNumber = inputDate;
      // userActivitiesInitialization.createTechnique();
      // FirebaseFirestore.instance.collection('Users').doc(result.user!.uid).
      // collection('Activities').doc(inputDate).update({'Description' : FieldValue.delete()});
      // FirebaseFirestore.instance.collection('Users').doc(result.user!.uid).
      // collection('Activities').doc(inputDate).update({'Title' : FieldValue.delete()});

      databaseReference?.doc(result.user!.uid).set({
        "email": emailController.text,
        "age": ageController.text,
        "name": nameController.text,
      }).then((res) {
        isLoading = false;
        Navigator.pushReplacement(
          context,
          //MaterialPageRoute(builder: (context) => MyHomePage(title: "Stress Free")),
          MaterialPageRoute(builder: (context) => BinderPage(title: "Home Page")),
        );
      });

    }).catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    ageController.dispose();
  }
}