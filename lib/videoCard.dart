import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'Video.dart';
import 'videoCardExpansion.dart';

class CardObject{
  String title;
  String video;
  String link = '';
  String description = "";

  CardObject({required this.title, required this.description, required this.video, required this.link, });
  String get _title => title;
}



class MyCardWidget extends StatefulWidget {
  final CardObject cardObject;
  //final Function(bool) onFavoriteChanged;


  MyCardWidget({Key? key, required this.cardObject}) : super(key: key);
  //MyCardWidget({Key? key, required this.cardObject, required this.onFavoriteChanged}) : super(key: key);

  //final String title;
  final String description = "description";
  final int index = 0;


  @override
  _MyCardWidgetState createState() => _MyCardWidgetState();
}

class _MyCardWidgetState extends State<MyCardWidget> {
  final Video vid = Video();

  get video => widget.cardObject.video;

  @override
  void initState() {
    super.initState();
    //dbRef = FirebaseDatabase.instance.reference().child('liked');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(widget.cardObject._title),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(0),
                child: TextButton(
                  child: const Text('View Video'),
                  onPressed: ()  {
                    Navigator.push(context,
                        //navigate into expansion
                        //MaterialPageRoute(builder: (context) => cardExpansion(title: widget.cardObject.title, timeFrame: widget.cardObject.timeFrame,
                        //  link: widget.cardObject.link, video: widget.cardObject.video, description: widget.cardObject.description)));
                        MaterialPageRoute(builder: (context) => cardExpansion(cardObject: widget.cardObject,)));

                  },
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }




}