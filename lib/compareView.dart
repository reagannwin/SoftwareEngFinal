import 'package:flutter/material.dart';

import 'CSVHandler/Book.dart';

class CompareView extends StatefulWidget {
  final Book bookObject;
  List<Book> likeBooks = [];

  CompareView({Key? key, required this.bookObject, required this.likeBooks}) : super(key: key);

  @override
  _CompareViewState createState() => _CompareViewState();
}

class _CompareViewState extends State<CompareView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[200]!,
          title: Text("Compare"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: ListView(
          children: populateComparisonList(widget.likeBooks),
        )
    );
  }

  List<Widget> populateComparisonList(List<Book> data) {
    List<Widget> created = [];
    for(Book target in data) {
      created.add(comparisonWidget(target));
    }
    return created;
  }

  Widget comparisonWidget(Book target) {
    return Card(
      child: Flexible(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children : [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Edition: " + target.getEdition()),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Rating: " + target.getRating())
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Price: " + target.getPrice())
            )
          ]
        )
      )
    );
  }
}