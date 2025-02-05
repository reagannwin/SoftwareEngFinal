import '../CSVHandler/Book.dart';
class bookSearcher {

//  bookSearcher(List<Book> bookList) {allBooks = bookList;}
  bookSearcher();


  String inputSearch = "";
  List<Book> allBooks = <Book>[];
  String searchedTitlesString = "";
  List<Book> searchedBooks = <Book>[];
  List<String> searchedTitles = <String>[];

  void setList(List<Book> bookList) {allBooks = bookList;}

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
      if (allBooks[i].title.toLowerCase().contains(newInput
          .toLowerCase()) || allBooks[i].isbn13.toLowerCase().contains(newInput.toLowerCase()) || allBooks[i].author.toLowerCase().contains(newInput.toLowerCase())) {
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
}