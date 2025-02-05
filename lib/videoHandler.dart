//journalHandler handles the backend of Journals,
// reading and writing from the Firestore database

//Made by Lucas, with assistance from Shane

import 'package:cloud_firestore/cloud_firestore.dart';

import 'Video.dart';

class videoHandler {
  CollectionReference<Map<String, dynamic>>? databaseReference; // = FirebaseFirestore.instance.collection('Techniques');

  videoHandler (CollectionReference<Map<String, dynamic>> db) {
    databaseReference = db;
  }

  int dbCounter = 0;
  String inputNumber = 0.toString();


  //Video URLs
  String inputURL = "";
  //video titles
  String inputTitle = "";
  //list of all videos
  final allVideos = <Video>[];


  //retrieves a journal based on an inputed date
  Future<DocumentSnapshot> retrieveURL() {
    return databaseReference!.doc(inputNumber).get(); // added a ! right before .doc
    // Switched from inputTitle to inputNumber - Shane
  }

  //changes the inputBody to match the current date
  Future<void> getVideos() async {
    return await retrieveURL().then((DocumentSnapshot data) async {
      while (data.exists) {
        Video v1 = Video();
        v1.setTitle(data.get('Title').toString());
        v1.setVideoId(data.get('url').toString());
        v1.setDescription(data.get('Description').toString());
        v1.setLink(data.get('Link').toString());


        allVideos.add(v1);
        dbCounter ++;
        inputNumber = dbCounter.toString();
        data = await retrieveURL();
      }
    });
  }
}