
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../globals.dart' as globals;
import '../components/gallery-views.dart';
import 'screen.dart';

class ScreenThree extends Screen {
  ScreenThree();

  _ScreenThreeState state;

  @override
  _ScreenThreeState createState() {
    state = _ScreenThreeState();
    return state;
  }

  @override
  void setState() {
    state._setState();
  }
}

class _ScreenThreeState extends State<ScreenThree> {

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

  _listItem(int index) {
    Map<String, dynamic> _item = globals.database.currentUserHistory[index];
    Map<String, dynamic> _gallery = globals.database.currentGallery ?? {};
    return GalleryViews.viewCard(
        padding: new EdgeInsets.all(0),
        child: FlatButton(
            onPressed: () {
              globals.database.setCurrentItem(_item);
              globals.selectTab(1);
            },
            padding: new EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GalleryViews.sizedImage(0, 100,
                    "assets/images/van_gogh-head_shot.jpg",
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)
                    )
                ),
                Expanded(
                  child: Padding(
                    padding: new EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          _item["name"] ?? "",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: globals.titleColor
                          ),
                        ),
                        new Container(height: 5),
                        Text(
                          "- ${_item["artist"] ?? ""}",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: globals.textColor
                          ),
                        ),
                        Expanded(child: new Container()),
                        Row(
                          children: <Widget>[
                            GalleryViews.sizedImage(40, 50,
                                "assets/images/gallery logo.png",
                                fit: BoxFit.cover
                            ),
                            new Container(width: 5),
                            Expanded(
                              child: Text(
                                _gallery["name"] ?? "",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: globals.textColor,
                                    height: 1.5
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new Container(),
        backgroundColor: Colors.white,
        // elevation: 0,
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
        child: globals.database.currentUserHistory != null
            ? GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                padding: new EdgeInsets.all(15),
                children: List.generate(globals.database.currentUserHistory.length, (index) {
                  return _listItem(index);
                }),
                childAspectRatio: 0.7,
              )
            : new Container(),
      ),
    );
  }
}