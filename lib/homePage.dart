import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:goobers_final/bookSearcher.dart';

import 'package:goobers_final/CSVHandler/CSVHandler.dart';
import 'databaseHandler.dart';
import 'BookCard.dart';
import 'package:goobers_final/CSVHandler/Book.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  final String title = "home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;




  databaseHandler favoritesManager = databaseHandler(FirebaseFirestore.instance.collection(
      'Users').doc(FirebaseAuth.instance.currentUser?.uid).collection('Book List'));

  List<Book> favoritesList = <Book> [];

  CSVHandler csv = CSVHandler();

  bookSearcher searcher = bookSearcher();

  @override
  void initState() {
    csv.populateCSVHandler();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    Future<void> fave = favoritesManager.databaseGet();
    return FutureBuilder (
      future: fave,
      builder: (context, screenshot) {

        favoritesManager.databaseGet();
        /*
        if(bookList.isEmpty) {
          techniqueList = dbManager.allTechniques;
        }

         */
        searcher.setList(csv.getBooks());

        favoritesList = favoritesManager.allBooks;

        if(screenshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body:

            Column(
              children: [
                Text(
                    'Welcome ${user?.email ?? 'Unknown user'}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),),
                Expanded(
                  child: favoritesView(favoritesManager, favoritesList),
                ),
              ],

            ),
          );
        } // END IF

        else {
          return

            CircularProgressIndicator(
              value: null,
              strokeWidth: 5.0,
            );
        }

      }, // Builder
    ); //FutureBuilder
  } // Build

  Widget favoritesView(databaseHandler dbManager, List<Book> favoritesList) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text( "Your Book List:",
                style: TextStyle(
        fontWeight: FontWeight.bold,
    ),
          ),
          Expanded(
            child: ListView(
                children:
                listLoop(favoritesList)

            ),
          ),
        ]
    );
  }
  List<Widget> listLoop(List<Book> favoritesList) {
    bool isFave = false;
    List<Widget> built = [];

    if (favoritesList.isNotEmpty) {
      for (int i = 1; i < favoritesList.length; i++) {
        // Favorites search
        if (favoritesList.isNotEmpty) {
   
        }

        if (favoritesList[i].isFavorite == true) {
          built.add(MyCardWidget(bookObject: favoritesList[i],favoritesManager: favoritesManager,
              searcher: searcher));
        }
      }
    }

    return built;
  }

}

