//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goobers_final/videoCard.dart';
import 'package:goobers_final/videoHandler.dart';
import 'package:firebase_core/firebase_core.dart';

import 'videoCard.dart';
import 'Video.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key, required this.title});

  final String title;

  @override
  State<VideoPage> createState() => _VideoPage();
}

class _VideoPage extends State<VideoPage> {


  videoHandler videoManager = videoHandler(FirebaseFirestore.instance.collection(
      'Videos'));



  List<Video> videoList = <Video> [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  databaseHandler dbManager = databaseHandler(stressManagementDatabase);
    // List<Technique> techniqueList = <Technique> [];
    print("==========Starting Build==========");
    return FutureBuilder (
      // future: dbManager.databaseGet(),
      future: (videoManager.getVideos()),
      builder: (context, screenshot) {
        if(videoList.isEmpty) {
          videoList = videoManager.allVideos;
        }



        if(screenshot.connectionState == ConnectionState.done) {
          // userManager.inputNumber = '1';
          // userManager.createTechnique();
          return Scaffold(

            body: Center(
              child: videosView(videoManager, videoList),
            ),
          );
        } // END IF

        else {
          return
            /*
      Text(
      "Loading",
      textAlign: TextAlign.center,
    );

       */
            CircularProgressIndicator(
              value: null,
              strokeWidth: 5.0,
            );
        }


        //dbManager.databaseGet();

      }, // Builder
    ); //FutureBuilder
  } // Build


  Widget videosView(videoHandler videoManager, List<Video> videoList)
  {
//    return FutureBuilder(
//        future: dbManager.databaseGet(),
//        builder: (context, screenshot) {
//  dbManager.databaseGet();
    return Column(
        children: [
          SizedBox(
            height: 4,
          ),



          Expanded(
            child: ListView(
              //children: testLoop(dbManager)
                children: listLoop(videoList)

            ),
          ),
        ]
    );
    // });
  }


  List<Widget> listLoop(List<Video> videoList)  {


    List<Widget> built = [];
    for(int i=0; i<videoList.length; i++) {
      //Favorites search

      built.add(MyCardWidget(cardObject: CardObject(title: videoList[i].title, description: videoList[i].description,
          video: videoList[i].vidId,
          link: videoList[i].link)));
    }
// isFavorite: isFave
    return built;
  }


}