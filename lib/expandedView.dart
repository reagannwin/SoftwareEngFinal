import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CSVHandler/Book.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class expandedView extends StatefulWidget{
  expandedView({super.key, required this.book});

  final Book book;

  static Book getCard(expandedView book) {return book.book;}


  @override
  _expandedView createState() => _expandedView();

}

class _expandedView extends State<expandedView> {
  //YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    Book book = expandedView.getCard(widget);
  }
  @override
  Widget build(BuildContext context) {
    Book book = widget.book;

    Widget titleCard = Container(
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
      child: Row(
        children:[
          Expanded(
            child: Text(book.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),

          ),
          Text(//book.edition as String,
            book.edition.toString(),
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 16.0,
            ),
          ),


        ],
      ),



    );

    Widget descriptionCard = Container(
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 32),
//      padding: const EdgeInsets.all(32),
      child: Row(
        children:[
          Expanded(
            child: Text(book.description,
              style: const TextStyle(
                //         fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),

          ),
         // Text("Publish Date:"),
          Text(book.published,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 16.0,
            ),
          ),

        ],
      ),
    );

    Widget authorCard = Container(
      padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
      child: Row(
        children:[
          Expanded(
            child: Text(book.author,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),

          ),
        ],
      ),
    );

    Widget otherInfoCard = Container(
      //padding: const EdgeInsets.fromLTRB(0,16, 325,0),

      padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
      child: Row(
        children: [
          Expanded(child: Text("Testtttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt")),

        ],
      ),
    );

    Widget priceCard = Container(
      padding: const EdgeInsets.fromLTRB(32, 10, 0, 0),
      child: Row(
        children:[
          Expanded(
            child: Text(book.price,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),

          ),
        ],
      ),
    );


    Widget infoSection = Container(
      //padding: const EdgeInsets.all(16),
      padding: const EdgeInsets.fromLTRB(20,16, 164,0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          Column(
            children: [
            ],
          ),
          Text(//book.rating as String,
            book.rating.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
            ),
          ),
          RatingBarIndicator(
            rating: double.parse(book.rating),
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 25.0,
            direction: Axis.horizontal,
          ),
          Text(//book.reviewCount as String,
            book.reviewCount.toString(),
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12.0,
            ),
          ),

        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200]!,
        title: Text(book.title),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),

      body:

      Column(
        children: [
          titleCard,
          authorCard,
          //videoplayer if(card.video != "null") videoPlayer,
          infoSection,
          priceCard,
          descriptionCard,
          //otherInfoCard,
        ],

      ),

    );
  }



//
}

/*

    Book card = widget.book;
    Widget techniqueBody = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                     // card.timeFrame,
                      "book",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                //link opener
                /*  InkWell(
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Open Browser',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    /*url launcher
                    onTap: () => launchUrlString(
                        card.link),*/
                  )*/

                ]
            ),
          ),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child:  Text(
        card.description,
        softWrap: true,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200]!,
        title: Text(card.title),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),


      ),

      body:

      Column(
        children: [
          techniqueBody,
          //videoplayer if(card.video != "null") videoPlayer,
          textSection,
        ],
      ),

    );

*/