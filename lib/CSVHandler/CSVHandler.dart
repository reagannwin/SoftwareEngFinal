import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'Book.dart';
import 'package:flutter/services.dart' show rootBundle;

class CSVHandler {
  final String csvAsset = "assets/Amazon Books Data.csv";
  List<Book> _books = [];
  String _bookCSV = "";

  CSVHandler() {}

  void populateCSVHandler() async {
    if (_books.isEmpty) {
      print("Populating CSVHandler (_books was empty)");
      _bookCSV = await rootBundle.loadString(csvAsset);

      List<List<dynamic>> data = CsvToListConverter().convert(_bookCSV);
      if (data.isNotEmpty) {
        data.forEach(_bookFactory);
      }
      else {
        print("ERROR: no CSV data to convert");
      }
    }
    else {
      print("CSVHandler already populated (_books was not empty)");
    }
  }

  void _bookFactory(List<dynamic> data) {
    Book created = Book();
    created.populateBook(data);
    _books.add(created);
  }

  List<Book> getBooks() {
    return _books;
  }
}