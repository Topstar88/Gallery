
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../globals.dart' as globals;
import '../components/gallery-views.dart';
import 'screen.dart';

class ScreenOne extends Screen {
  ScreenOne();

  _ScreenOneState state;

  @override
  _ScreenOneState createState() {
    state = _ScreenOneState();
    return state;
  }

  @override
  void setState() {
    state._setState();
  }
}

class _ScreenOneState extends State<ScreenOne> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _setState() {
    setState(() {

    });
  }

  _itemArticle() {
    Map<String, dynamic> _title = globals.database.currentGalleryFeed["title"] ?? {};
    return GalleryViews.viewCard(
      padding: new EdgeInsets.fromLTRB(15, 25, 15, 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset(
              "assets/images/art_gallery logo.png"
          ),
//          new Container(height: 5),
//          Text(
//            "FINE ART",
//            style: TextStyle(
//                fontSize: 20,
//                fontWeight: FontWeight.w400,
//                color: globals.articleSubtitleColor
//            ),
//            textAlign: TextAlign.center,
//          ),
          new Container(height: 20),
          Text(
            _title["description"] ?? "",
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

  _itemGalleryMap() {
    Map<String, dynamic> _map = globals.database.currentGalleryFeed["map"] ?? {};
    return GalleryViews.viewCard(
        padding: new EdgeInsets.fromLTRB(15, 25, 15, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              _map["title"] ?? "",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: globals.titleColor
              ),
              textAlign: TextAlign.left,
            ),
            new Container(height: 20),
            Image.asset(
              "assets/images/gallery-floor_plan.jpg"
            )
          ],
        )
    );
  }

  _itemBuyPrints() {
    Map<String, dynamic> _prints = globals.database.currentGalleryFeed["prints"] ?? {};
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
              _prints["title"] ?? "",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: globals.titleColor
              ),
              textAlign: TextAlign.left,
            ),
            new Container(height: 20),
            Text(
              _prints["description"] ?? "",
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

  _itemUpcomingEvents() {
    Map<String, dynamic> _events = globals.database.currentGalleryFeed["events"] ?? {};
    return GalleryViews.viewCard(
        padding: new EdgeInsets.fromLTRB(0, 25, 0, 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: new EdgeInsets.only(left: 15, right: 15),
              child: Text(
                _events["title"] ?? "",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: globals.titleColor
                ),
                textAlign: TextAlign.left,
              ),
            ),
            new Container(height: 20),
            GalleryViews.sizedImage(0, 300,
                "assets/images/van_gogh-head_shot.jpg",
                fit: BoxFit.cover
            ),
            new Container(height: 20),
            Padding(
              padding: new EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "Summer Nights",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: globals.titleColor
                ),
                textAlign: TextAlign.left,
              ),
            ),
            new Container(height: 20),
            Padding(
              padding: new EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "Join us June 1st - 3rd for the best night in art.",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: globals.textColor
                ),
                textAlign: TextAlign.left,
              )
            ),
          ],
        )
    );
  }

  _itemDigitalTicket() {
    Map<String, dynamic> _tickets = globals.database.currentGalleryFeed["ticket"] ?? {};
    return GalleryViews.viewCard(
        padding: new EdgeInsets.fromLTRB(15, 25, 15, 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              _tickets["title"] ?? "",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: globals.titleColor
              ),
              textAlign: TextAlign.left,
            ),
            new Container(height: 20),
            GalleryViews.sizedImage(0, 200,
                "assets/images/qrcode.jpg"
            ),
            new Container(height: 20),
            Text(
              _tickets["description"] ?? "",
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

  _listItem(int index) {
    Widget _item;
    if (index % 5 == 0) {
      _item = _itemArticle();
    } else if (index % 5 == 1) {
      _item = _itemGalleryMap();
    } else if (index % 5 == 2) {
      _item = _itemBuyPrints();
    } else if (index % 5 == 3) {
      _item = _itemUpcomingEvents();
    } else {
      _item = _itemDigitalTicket();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _item,
        new Container(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new Container(),
        backgroundColor: Colors.white,
        title: Text(
          "Fabula",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Colors.black
          ),
        ),
      ),
      body: new Container(
        color: Color(0xffe0e0e0e0),
        child: ListView.builder(
            itemCount: 5,
            padding: new EdgeInsets.fromLTRB(15, 15, 15, 0),
            itemBuilder: (BuildContext context, int index) {
              return _listItem(index);
            }
        ),
      ),
    );
  }
}