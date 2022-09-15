import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../globals.dart' as globals;

class SearchDialog extends StatefulWidget {
  SearchDialog({this.onSearch});

  Function(String) onSearch;
  @override
  _SearchDialogState createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {

  TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: new Stack(
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.all(0),
            color: Colors.black.withOpacity(0.1),
          ),
          new Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.circular(5.0)),
                  margin: new EdgeInsets.only(left: 10, right: 10),
                  child: new Container(
                    margin: new EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                              labelText: "Search..."
                          ),
                        ),
                        new Container(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              child: Text(
                                  "Search"
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                if (widget.onSearch != null) {
                                  widget.onSearch(_controller.text);
                                }
                              },
                            ),
                            new Container(width: 20),
                            FlatButton(
                              child: Text(
                                  "Cancel"
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}