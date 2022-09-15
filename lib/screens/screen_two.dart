
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../globals.dart' as globals;
import '../components/gallery-views.dart';
import '../components/videoplayer.dart';
import '../components/scenes.dart';
import '../components/audioplayer.dart';
import '../components/comments.dart';
import 'screen.dart';

class ScreenTwo extends Screen {
  ScreenTwo();

  _ScreenTwoState state;

  @override
  _ScreenTwoState createState() {
    state = _ScreenTwoState();
    return state;
  }

  @override
  void setState() {
    state._setState();
  }
}

class _ScreenTwoState extends State<ScreenTwo> {

  bool _itemHasHeart = false;
  CustomAudioPlayer _audio;
  CustomVideoPlayer _video;
  Scenes _scenes;

  @override
  void initState() {
    super.initState();

    _video = CustomVideoPlayer();
    _audio = CustomAudioPlayer();
    _scenes = Scenes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _setState() {
    setState(() {

    });
  }

  _itemVideo() {
    return _video;
  }

  _itemImage() {
    Map<String, dynamic> _artist = globals.database.currentItemFeed["aboutArtist"] ?? {};
    return GalleryViews.viewCard(
        padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GalleryViews.sizedImage(0, 200,
                "assets/images/van_gogh-head_shot.jpg",
                fit: BoxFit.cover,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5)
                )
            ),
            Text(
              _artist["title"] ?? "",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: globals.titleColor
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              _artist["description"] ?? "",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: globals.textColor
              ),
              textAlign: TextAlign.left,
            )
          ],
        )
    );
  }

  _itemScene() {
    return _scenes;
  }

  _itemBuyPrints() {
    return GalleryViews.viewCard(
        padding: new EdgeInsets.fromLTRB(15, 15, 15, 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GalleryViews.sizedImage(0, 200,
                "assets/images/van_gogh-bed_room-print.jpeg"
            ),
            new Container(height: 20),
            Text(
              "Buy Prints",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: globals.titleColor
              ),
              textAlign: TextAlign.left,
            ),
            new Container(height: 20),
            Text(
              "If the gallery sells prints they can sell them here",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: globals.textColor
              ),
              textAlign: TextAlign.left,
            )
          ],
        )
    );
  }

  _itemAudio() {
    return _audio;
  }

  _itemArticle() {
    return GalleryViews.viewCard(
        padding: new EdgeInsets.fromLTRB(15, 25, 15, 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "If you like this then you will love...",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: globals.titleColor
              ),
              textAlign: TextAlign.left,
            ),
            new Container(height: 20),
            GalleryViews.sizedImage(0, 200,
                "assets/images/impressionist_example.jpeg"
            ),
            new Container(height: 20),
            Text(
              "Another Impressionist Example",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: globals.titleColor
              ),
              textAlign: TextAlign.left,
            ),
            new Container(height: 20),
            Text(
              "Mr Impressionist",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: globals.textColor
              ),
              textAlign: TextAlign.left,
            ),
            new Container(height: 20),
            Text(
              "Located down the hall to your left in the new items room",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: globals.textColor
              ),
              textAlign: TextAlign.left,
            ),
          ],
        )
    );
  }

  _itemTalk() {
    return GalleryViews.viewCard(
        padding: new EdgeInsets.fromLTRB(15, 25, 15, 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Talk with the artist",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: globals.titleColor
              ),
              textAlign: TextAlign.left,
            ),
            new Container(height: 20),
            Text(
              "Love the piece? Have more questions about the story behind the piece?",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: globals.textColor
              ),
              textAlign: TextAlign.left,
            ),
            new Container(height: 20),
            Text(
              "Send the artist a private message and they will get back to you as soon as they put down the brush :)",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: globals.textColor
              ),
              textAlign: TextAlign.left,
            ),
            new Container(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: "Message to Artist"
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: globals.textColor,
                  ),
                  onPressed: () {

                  },
                )
              ],
            )
          ],
        )
    );
  }

  _itemComment() {
    return Comments();
  }

  _listItem(int index) {
    Widget _item;
    if (index % 8 == 0) {
      _item = _itemVideo();
    } else if (index % 8 == 1) {
      _item = _itemImage();
    } else if (index % 8 == 2) {
      _item = _itemScene();
    } else if (index % 8 == 3) {
      _item = _itemBuyPrints();
    } else if (index % 8 == 4) {
      _item = _itemAudio();
    } else if (index % 8 == 5) {
      _item = _itemArticle();
    } else if (index % 8 == 6) {
      _item = _itemTalk();
    } else {
      _item = _itemComment();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _item,
        new Container(height: 15)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new Container(),
        backgroundColor: Colors.white,
        // elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              _itemHasHeart ? Icons.favorite : Icons.favorite_border,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                _itemHasHeart = !_itemHasHeart;
              });
            },
          )
        ],
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              globals.database.currentItem["name"] ?? "",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black
              ),
            ),
            Text(
              globals.database.currentItem["artist"] ?? "",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: globals.titleColor
              ),
            )
          ],
        ),
      ),
      body: new Container(
        color: Color(0xffe0e0e0e0),
        child: ListView.builder(
            itemCount: 8,
            padding: new EdgeInsets.fromLTRB(15, 15, 15, 0),
            itemBuilder: (BuildContext context, int index) {
              return _listItem(index);
            }
        ),
      ),
    );
  }
}