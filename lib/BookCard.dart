import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CSVHandler/Book.dart';
import 'expandedView.dart';
import 'package:goobers_final/databaseHandler.dart';
import 'bookSearcher.dart';
import 'compareView.dart';

class MyCardWidget extends StatefulWidget {
  final Book bookObject;
  databaseHandler favoritesManager; //Decided to move from Book to Card
  bookSearcher searcher;
  //final bool favoriteStatus;
  //final Function(bool) onFavoriteChanged;


  MyCardWidget({Key? key, required this.bookObject,required this.favoritesManager,
  required this.searcher}) : super(key: key);

  bool isFavorite = false;

  @override
  _MyCardWidgetState createState() => _MyCardWidgetState();
}


class _MyCardWidgetState extends State<MyCardWidget> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    //dbRef = FirebaseDatabase.instance.reference().child('liked');
  }
  _toggleFavorite(Book bookObject) {
    setState(() {
      if (widget.bookObject.isFavorite) {
        _isFavorite = false;
        widget.bookObject.isFavorite = false;
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
        widget.favoritesManager.removeFavorite(t1);
      } else {
        _isFavorite = true;
        widget.bookObject.isFavorite = true;
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
        widget.favoritesManager.addFavorite(t1);

        // Save into database
        //Assign index?
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(widget.bookObject.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,

              ),
            ),
            subtitle: Column(
              children: [
                Text(
                  "By ${widget.bookObject.author}",
                  style: TextStyle(
                    color: Colors.grey[500],

                  ),
                ),
                widget.bookObject.bestSeller == true
                    ? Container(
                  padding: const EdgeInsets.all(8.0), // Adjust padding as needed
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent, // Set the highlight color
                    borderRadius: BorderRadius.circular(8.0), // Optional: add rounded corners
                  ),
                  child: const Text(
                    "Best Seller",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Set the text color
                    ),
                  ),
                )
                    : Container(), //
              ],// If not a best seller, set subtitle to null/ if not a best seller, set subtitle to null
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: Text("Compare"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CompareView(
                        bookObject: widget.bookObject,
                        likeBooks: getSimilarBooks(),
                      )
                    )
                  );
                },
              ),
              Container(
                padding: const EdgeInsets.all(0),
                child: TextButton(
                  child: const Text('See more details'),
                  onPressed: ()  {
                    Navigator.push(context,
                        //navigate into expansion
                        //MaterialPageRoute(builder: (context) => cardExpansion(title: widget.cardObject.title, timeFrame: widget.cardObject.timeFrame,
                        //  link: widget.cardObject.link, video: widget.cardObject.video, description: widget.cardObject.description)));
                        MaterialPageRoute(builder: (context) => expandedView(book: widget.bookObject,)));

                  },
                ),
              ),
              IconButton(
                padding: const EdgeInsets.all(0),
                alignment: Alignment.centerRight,
                icon: widget.bookObject.isFavorite //use this to pull isFavorite from the book object
                //icon: widget.isFavorite            //use this to pull isFavorite from the widget
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_border),
                color: Colors.red[500],
                onPressed: () => _toggleFavorite(widget.bookObject),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }

  List<Book> getSimilarBooks() {
    widget.searcher.inputSearch = widget.bookObject.getTitle();
    widget.searcher.techniqueTitleSearch();
    return widget.searcher.searchedBooks;
  }
}

