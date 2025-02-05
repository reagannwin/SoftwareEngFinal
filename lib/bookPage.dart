//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goobers_final/CSVHandler/CSVHandler.dart';
import 'package:goobers_final/bookSearcher.dart';
import 'bookSearcher.dart';
import 'databaseHandler.dart';
import 'package:goobers_final/BookCard.dart';
import 'package:firebase_core/firebase_core.dart';

import '../CSVHandler/Book.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key, required this.title});

  final String title;

  @override
  State<BookPage> createState() => _BookPage();
}

class _BookPage extends State<BookPage> {
  String searchValue = '';

  /*
  databaseHandler dbManager = databaseHandler(FirebaseFirestore.instance.collection(
      'Techniques'));

  databaseHandler favoritesManager = databaseHandler(FirebaseFirestore.instance.collection(
      'Users').doc(FirebaseAuth.instance.currentUser?.uid).collection('Favorites'));
   */


  //csv parser doesnt work
  CSVHandler csv = CSVHandler();

  databaseHandler userBookManager = databaseHandler(FirebaseFirestore.instance.collection(
      'Users').doc(FirebaseAuth.instance.currentUser?.uid).collection('Book List'));
  bookSearcher searcher = bookSearcher();

  List<Book> bookList = <Book> [];
  // bookList will come from csvParser
  List<Book> favoritesList = <Book> [];
  List<String> sortedSuggestions = <String> [];

  Book testBook1 = Book();
  Book testBook2 = Book();
  List<Book> testList = <Book> [];

@override
  void initState() {
  csv.populateCSVHandler();
    // TODO: implement initState
    super.initState();
}

  @override
  Widget build(BuildContext context) {
    testBook1.setTitle("Lord of the Flies");
    testBook1.setAuthor("Shane");
    testBook1.setDescription("Child Battle Royale");
    testBook1.setBestSeller("Yes");


    testList.add(testBook1);
    testList.add(testBook2);
   // Future<void> fave = favoritesManager.databaseGet();
    //Future<void> csvFill = csv.populateCSVHandler();
    return FutureBuilder (
      //future: Future.wait([userBookManager.databaseGet(), csvFill]),
      future: userBookManager.databaseGet(),
      builder: (context, screenshot) {
      //  csv.populateCSVHandler();
      // favoritesManager.databaseGet();
        print(csv.getBooks());
        print(csv.getBooks().length);

        if(bookList.isEmpty) {
          bookList = csv.getBooks();
          //bookList = testList;
        }
        searcher.setList(csv.getBooks());
        //searcher.setList(testList);

        favoritesList = userBookManager.allBooks;
        //bookList = csv.getBooks();

        if(screenshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: Center(
              child: booksView(searcher, bookList),
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


  Widget booksView(bookSearcher searcher, List<Book> bookList)
  {
  return Column(
  children: [
    SizedBox(
      height: 4,
    ),


  SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          controller: controller,
          padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0)),
          onTap: () {
          },
          onChanged: (value) {
            controller.openView();
          },
          onSubmitted: (value) {
            searcher.inputSearch = value;
            searchValue = value;
            updateSearch();
          },

          leading: const Icon(Icons.search),
          trailing: <Widget>[
            Tooltip(
              message: 'Reset search',
              child: IconButton(
                onPressed: () {
                  searchValue = '';
                  updateSearch();
                },
                icon: const Icon(Icons.autorenew),
              ),
            )
          ],
        );
      },
      suggestionsBuilder:
      (BuildContext context, SearchController controller) {
        return List<ListTile>.generate(searcher.bookSearch(controller.text).length, (int index) {
          String item = searcher.allBooks[index].title;

          if(controller.text.isNotEmpty) {
            item = searcher.searchedBooks[index].title;
          }

        return ListTile(
        title: Text(item),
        onTap: () {
          setState(() {
            controller.closeView(item);
            searchValue = item;
            updateSearch();
          });
        },
      );
    });
  }
  ),
    Expanded(
      child: ListView(
      children: listLoop(bookList)

  ),
  ),
  ]
  );
 // });
  }

  void updateSearch() {
    setState(() {
      bookList = searcher.bookSearch(searchValue); //Will need a search helper or something
      favoritesList.clear();
      userBookManager.dbCounter = 0;
      userBookManager.allBooks.clear();
      userBookManager.inputNumber = userBookManager.dbCounter.toString();
    });
  }

  List<Widget> listLoop(List<Book> bookList)  {
    bool isFave = false;

    List<Widget> built = [];
    for(int i=0; i<bookList.length; i++) {
      //Favorites search

      if (favoritesList.isNotEmpty) {
          for (int j = 0; j < favoritesList.length; j++) {
            if (favoritesList[j].title == bookList[i].title) {
              isFave = true;
              bookList[i].setFavoriteStatus(true);
            }
          }

      }

      built.add(MyCardWidget(bookObject: bookList[i],favoritesManager: userBookManager,
          searcher: searcher));
      isFave = false;
    }
    return built;
  }

  List<Widget> makePageButtons() {
    List<Widget> built = [
      Text(
        "PageButtonsTestEntry",
        textAlign: TextAlign.center,
      ),
    ];

    return built;
  }

}