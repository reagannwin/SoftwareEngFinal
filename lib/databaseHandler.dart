import '../CSVHandler/Book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class databaseHandler {
  CollectionReference<Map<String, dynamic>>? databaseReference;

  databaseHandler (CollectionReference<Map<String, dynamic>> db) {
    databaseReference = db;
  }


  int dbCounter = 0;

  String? inputDescription;
  String? inputTitle;
  String inputNumber = 0.toString();
  String inputSearch = "";
  String? techniqueInfo = "";
  final allBooks = <Book>[];
  bool getStatus = false;

  String searchedTitlesString = "";
  List<Book> searchedBooks = <Book>[];
  List<String> searchedTitles = <String>[];

  // Creates a new Technique in the database
  void createBook(){
    databaseReference!.doc(inputNumber).set({"Description" : inputDescription, "Title" : inputTitle}); // Added a ! right before .doc
  }

  /*
  // Gets a specific Technique from the database using an input document number
  Future<void> getVideoLink() async{
    DocumentSnapshot data = await retrieveData();

      techniqueInfo = data.data().toString();

      if (data.exists) {techniqueInfo = data.get('url').toString();} // Makes only the title display from the data


  }

   */

  // Gathers all of the Technique info from the database and builds a Technique
  // object for each Technique and adds each to a list of Techniques
  Future<void> databaseGet() async{
    return await retrieveData().then((DocumentSnapshot data) async {

      while(data.exists) {
        Book t1 = Book();
        t1.setTitle(data.get('Title').toString());
        t1.setFavoriteStatus(data.get('Favorite'));
        t1.setISBN10(data.get('isbn10').toString());
        t1.setISBN13(data.get('isbn13').toString());
        t1.setDescription(data.get('Description').toString());
        t1.setAuthor(data.get('Author').toString());
        t1.setPublishDate(data.get('Publish Date').toString());
        t1.setEdition(data.get('Edition').toString());
        t1.setBestSeller(data.get('Best Seller').toString());
        t1.setTopRated(data.get('Top Rated').toString());
        t1.setRating(data.get('Rating').toString());
        t1.setReviewCount(data.get('Review Count').toString());
        t1.setPrice(data.get('Price').toString());

        allBooks.add(t1);

        dbCounter ++;
        inputNumber = dbCounter.toString();
        data = await retrieveData();
      }
    });
  }

  Future<void> addFavorite(Book newBook) async {
    int faveNumber = 0;
    DocumentSnapshot data = await retrieveFavoriteData(faveNumber);

    while(data.exists) {
      faveNumber++;
      data = await retrieveFavoriteData(faveNumber);
    }

    databaseReference!.doc(faveNumber.toString()).set({
      "Description" : newBook.description,
      "Title" : newBook.title,
      "Favorite" : newBook.isFavorite,
      "isbn10" : newBook.isbn10,
      "isbn13" : newBook.isbn13,
      "Author" : newBook.author,
      "Publish Date" : newBook.published,
      "Edition" : newBook.edition,
      "Best Seller" : newBook.bestSeller,
      "Top Rated" : newBook.topRated,
      "Rating" : newBook.rating,
      "Review Count" : newBook.reviewCount,
      "Price" : newBook.price
    }); // Added a ! right before .doc


    /*
    Book t1 = Book();
        t1.setTitle(widget.bookObject.title);
        t1.setFavoriteStatus(widget.bookObject.isFavorite);
        t1.setAuthor(widget.bookObject.author);
        t1.setISBN10(widget.bookObject.isbn10);
        t1.setISBN13(widget.bookObject.isbn13);
        t1.setDescription(widget.bookObject.description);
        t1.setPublishDate(widget.bookObject.published);
        t1.setEdition(widget.bookObject.edition);
        t1.setBestSeller(widget.bookObject.bestSeller);
        t1.setTopRated(widget.bookObject.topRated);
        t1.setRating(widget.bookObject.rating);
        t1.setReviewCount(widget.bookObject.reviewCount);
        t1.setPrice(widget.bookObject.price);
     */

   // databaseReference!.doc(faveNumber.toString()).set({"title" : newBook.title}); // Added a ! right before .doc
  }

  Future<void> removeFavorite(Book chopBook) async {
    int faveNumber = 0;
    int? replaceNumber;
    DocumentSnapshot data = await retrieveFavoriteData(faveNumber);

    while(data.exists){

      if (data.get('Title').toString() == chopBook.title) {
        databaseReference!.doc(faveNumber.toString()).delete();
        faveNumber--;
      }

      faveNumber++;
      data = await retrieveFavoriteData(faveNumber);

    }

    replaceNumber = faveNumber;
    faveNumber++;
    data = await retrieveFavoriteData(faveNumber);

    if (data.exists) {
      while (data.exists) {
        faveNumber++;
        data = await retrieveFavoriteData(faveNumber);
      }
      faveNumber--;
      data = await retrieveFavoriteData(faveNumber);

      Book rb = Book();
      rb.setTitle(data.get('Title'));
      rb.setTitle(data.get('Title').toString());
      rb.setFavoriteStatus(data.get('Favorite'));
      rb.setISBN10(data.get('isbn10').toString());
      rb.setISBN13(data.get('isbn13').toString());
      rb.setDescription(data.get('Description').toString());
      rb.setAuthor(data.get('Author').toString());
      rb.setPublishDate(data.get('Publish Date').toString());
      rb.setEdition(data.get('Edition').toString());
      rb.setBestSeller(data.get('Best Seller').toString());
      rb.setTopRated(data.get('Top Rated').toString());
      rb.setRating(data.get('Rating').toString());
      rb.setReviewCount(data.get('Review Count').toString());
      rb.setPrice(data.get('Price').toString());
      addFavorite(rb);

      databaseReference!.doc(faveNumber.toString()).delete();
    }
  }

  void searchClear() {
    searchedBooks.clear();
    searchedTitlesString = "empty";
    searchedTitles.clear();
  }

  // Searches through the list of techniques from a user string,
  // Creates a new list with the search results
  List<Book> bookSearch(String newInput) {
    searchClear();

    for (int i = 0; i < allBooks.length; i++) {
      if (allBooks[i].title.toLowerCase().contains(newInput.toLowerCase()) /*|| allBooks[i].tags.toLowerCase().contains(newInput.toLowerCase())*/) {
        searchedBooks.add(allBooks[i]);
      }
    }

    return searchedBooks;
  }

  String techniqueTitleSearch() {
    searchClear();
    print(searchedTitlesString);

    for (int i = 0; i < allBooks.length; i++) {
      if (allBooks[i].title.contains(inputSearch)) {
        searchedBooks.add(allBooks[i]);
        searchedTitles.add(allBooks[i].title);
      }
    }

    String retrievedStrings = searchedTitles.join(',');

    return retrievedStrings;
  }

  // Returns a specific Technique from the database using an input document number
  Future<DocumentSnapshot> retrieveData() async{
    return databaseReference!.doc(inputNumber).get();
  }

  Future<DocumentSnapshot> retrieveFavoriteData(int input) async{
    return databaseReference!.doc(input.toString()).get();
  }

  // Removes a technique from the database
  void removeTechnique(){
    databaseReference!.doc(inputNumber).delete(); // added a ! right before .doc
  }

  void printTest() {
    for(int i=0; i < allBooks.length; i++) {
      print("==============");
      print(allBooks[i].title);
    }
  }

  Book BlankBook() {
    List<int> dummyList = <int>[0,1,2,3,4,5,6,7,8,9,10,11];
    Book blankBook = Book();
    return blankBook;
  }

}