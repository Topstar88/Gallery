import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../globals.dart' as globals;
import '../components/gallery-views.dart';

class Comments extends StatefulWidget {
  Comments();

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _commentItem() {
    return new Container(
      color: globals.commentColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Container(height: 20),
          Padding(
            padding: new EdgeInsets.only(left: 15, right: 15),
            child: Text(
              "John Doe",
              style: TextStyle(
                  fontSize: 14,
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
              "I love this piece it touched my soul :) :O",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: globals.textColor
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Divider(color: globals.titleColor, height: 1)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GalleryViews.viewCard(
        padding: new EdgeInsets.fromLTRB(0, 25, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: new EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Comments",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: globals.titleColor
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "24",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: globals.titleColor
                    ),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
            ),
            new Container(height: 20),
            Padding(
              padding: new EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: "Your Public Comment"
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
              ),
            ),
            new Container(height: 5),
            ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return _commentItem();
                },
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: new EdgeInsets.all(0),
            )
          ],
        )
    );
  }
}