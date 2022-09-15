import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../globals.dart' as globals;
import '../components/gallery-views.dart';

class Scenes extends StatefulWidget {
  Scenes();

  @override
  _ScenesState createState() => _ScenesState();
}

class _ScenesState extends State<Scenes> {

  PageController _controller;

  int _index = 0;
  int _count = 3;

  List<String> _imageUrl = [
    "https://source.unsplash.com/category/nature/500x300",
    "https://source.unsplash.com/category/food/500x300",
    "https://source.unsplash.com/category/buildings/500x300"
  ];

  @override
  void initState() {
    super.initState();

    _controller = new PageController(initialPage: 0, viewportFraction: 1);
    _controller.addListener(_onChanged);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void _onChanged() {
    setState(() {
      _index = _controller.page.round();
    });
  }

  _selectPage(int index) {
    _controller.animateToPage(
        index,
        duration: Duration(milliseconds: 100),
        curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return GalleryViews.viewCard(
        padding: new EdgeInsets.fromLTRB(15, 30, 15, 25),
        child: new Container(
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Behind the scenes",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: globals.titleColor
                ),
                textAlign: TextAlign.left,
              ),
              new Container(height: 20),
              Expanded(
                child: new Container(
                  child: new PageView.builder(
                    physics: new AlwaysScrollableScrollPhysics(),
                    controller: _controller,
                    itemCount: _count,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            "Title ${index + 1}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: globals.titleColor
                            ),
                            textAlign: TextAlign.left,
                          ),
                          new Container(height: 20),
                          Expanded(
                              child: CachedNetworkImage(
                                  imageUrl: _imageUrl[index]
                              )
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back
                    ),
                    onPressed: () {
                      if (_index > 0) {
                        _index -= 1;
                      }
                      _selectPage(_index);
                    },
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_count, (index) {
                        return IconButton(
                          icon: Icon(
                              _index == index
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_unchecked
                          ),
                          onPressed: () {
                            _index = index;
                            _selectPage(_index);
                          },
                        );
                      }),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                        Icons.arrow_forward
                    ),
                    onPressed: () {
                      if (_index < _count - 1) {
                        _index += 1;
                      }
                      _selectPage(_index);
                    },
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}