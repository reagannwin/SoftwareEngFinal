import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'videoCard.dart';

class cardExpansion extends StatefulWidget{
  cardExpansion({super.key, required this.cardObject});

  final CardObject cardObject;

  static CardObject getCard(cardExpansion card) {return card.cardObject;}


  @override
  _cardExpansion createState() => _cardExpansion();

}

class _cardExpansion extends State<cardExpansion> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    CardObject card = cardExpansion.getCard(widget);

    _controller = YoutubePlayerController(
        initialVideoId: card.video,
        //cardExpansion.getVideo(widget),
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          isLive: false,
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    Widget videoPlayer = Container(
      child: YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
      ),
    );

    CardObject card = widget.cardObject;
    Widget techniqueBody = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
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
                    onTap: () => launchUrlString(
                        card.link),
                  )

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
          if(card.video != "null") videoPlayer,
          textSection,
        ],
      ),

    );


  }



//
}