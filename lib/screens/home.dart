import 'package:flutter/material.dart';

import 'package:tflite/tflite.dart';

import 'screen_one.dart';
import 'screen_two.dart';
import 'screen_three.dart';
import '../globals.dart' as globals;
import 'screen.dart';
import '../database/database.dart';
import '../components/camera.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Screen> _children = [
    ScreenOne(),
    ScreenTwo(),
    ScreenThree()
  ];

  @override
  void initState() {
    super.initState();

    globals.fetchData = fetchData;
    globals.selectTab = onTabTapped;
    globals.database = Database();

    Tflite.loadModel(
        model: "assets/tflite/mobilenet_v1_1.0_224.tflite",
        labels: "assets/tflite/mobilenet_v1_1.0_224.txt",
        numThreads: 1 // defaults to 1
    );
//    fetchData();
  }

  void fetchData() {
    globals.database.getCurrentGallery("58WuX2TaqXFLeBL5zE16").then((gallery) {
      globals.database.currentGallery = gallery;
      _children[_currentIndex].setState();
    });

    globals.database.getCurrentGalleryFeed("58WuX2TaqXFLeBL5zE16").then((galleryFeed) {
      globals.database.currentGalleryFeed = galleryFeed;
      _children[_currentIndex].setState();
    });

    globals.database.getCurrentGalleryItems("58WuX2TaqXFLeBL5zE16").then((galleryItems) {
      globals.database.currentGalleryItems = galleryItems;
      _children[_currentIndex].setState();
    });

    globals.database.getUserHistory(globals.database.currentUser.uid).then((history) {
      globals.database.currentUserHistory = history;
      _children[_currentIndex].setState();
    });
  }

  void findItem(String itemClass) {
//    globals.database.getCurrentGalleryItemByClass(globals.database.currentGallery['id'] ?? "", itemClass)
//        .then((newItem) {
//      globals.database.setCurrentItem(newItem);
//      globals.database.addItemToUserHistory(globals.database.currentUser.uid, newItem).then((history) {
//        globals.database.currentUserHistory.add(history);
//      });
//    });
    var _newItem = globals.database.currentGalleryItems.firstWhere((item) {
      String _class = item["class"] ?? "";
      return _class.contains(itemClass);
    });
    print(_newItem);
    if (_newItem != null) {
      globals.database.setCurrentItem(_newItem);
      globals.database.addItemToUserHistory(globals.database.currentUser.uid, _newItem).then((history) {
        globals.database.currentUserHistory.add(history);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Fabula'),
      // ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        backgroundColor: globals.activeColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            title: Text('GALLERY'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            title: Text('WORKS'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            title: Text('HISTORY')
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.remove_red_eye, size: 40,),
          backgroundColor: globals.activeColor,
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => CustomCamera(
                  onComplete: (detected) {
                    findItem(detected);
                  },
                ),
              ),
            );
          }
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    }); 
  }
}