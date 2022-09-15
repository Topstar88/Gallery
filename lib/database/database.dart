import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../globals.dart' as globals;

class Database {
  List<Map<String, dynamic>> currentGalleryItems = [];
  Map<String, dynamic> currentGalleryFeed = {};
  Map<String, dynamic> currentGallery = {};
  List<Map<String, dynamic>> currentUserHistory = [];
  FirebaseUser currentUser;
  Map<String, dynamic> currentItem = {};
  Map<String, dynamic> currentItemFeed = {};

  Database() {
    this.signIn("admin@deea.co", "pass1234");
    globals.firebaseAuth.onAuthStateChanged.listen((user) {
      if (user != null) {
        currentUser = user;
        globals.fetchData();
      } else {
        currentUser = null;
      }
    });
  }

  void setCurrentItem(Map<String, dynamic> _newItem) {
    currentItem = _newItem;
    getCurrentGalleryItemFeed(currentGallery['id'] ?? "", currentItem['id'] ?? "").then((itemFeed) {
      currentItemFeed = itemFeed;
      globals.selectTab(1);
    });
  }

  Future<Map<String, dynamic>> addItemToUserHistory(String userID, Map<String, dynamic> item) {
    var c = Completer<Map<String, dynamic>>();
    globals.firestore.collection('users').document(userID).collection('history').add(item).then((doc) {
      var tempItem = item;
      tempItem['id'] = doc.documentID;
      c.complete(item);
    }).catchError((error) {
      c.completeError(error);
    });
    return c.future;
  }

  Future<List<Map<String, dynamic>>> getUserHistory(String userID) {
    var c = Completer<List<Map<String, dynamic>>>();
    globals.firestore.collection('users').document(userID).collection('history').getDocuments().then((snap) {
      List<Map<String, dynamic>> tempUserHistory = [];
      snap.documents.forEach((doc) {
        var tempItem = doc.data;
        tempItem['id'] = doc.documentID;
        tempUserHistory.add(tempItem);
      });
      c.complete(tempUserHistory);
    }).catchError((error) {
      c.completeError(error);
    });
    return c.future;
  }

  Future<Map<String, dynamic>> getCurrentGalleryItemFeed(String galleryID, String itemID) {
    var c = Completer<Map<String, dynamic>>();
    globals.firestore.collection('galleries').document(galleryID)
      .collection('items').document(itemID)
      .collection('feed').getDocuments().then((snap) {
        Map<String, dynamic> tempCurrentItemFeed = {};
        snap.documents.forEach((doc) {
          tempCurrentItemFeed[doc.documentID] = doc.data;
        });
        c.complete(tempCurrentItemFeed);
    }).catchError((error) {
      c.completeError(error);
    });
    return c.future;
  }

  Future<Map<String, dynamic>> getCurrentGalleryItemByClass(String galleryID, String itemClass) {
    var c = Completer<Map<String, dynamic>>();
    globals.firestore.collection('galleries').document(galleryID)
      .collection('items').where("class", isEqualTo: itemClass).getDocuments().then((snap) {
      List<Map<String, dynamic>> tempItems = [];
      snap.documents.forEach((doc) {
        var tempItem = doc.data;
        tempItem['id'] = doc.documentID;
        tempItems.add(tempItem);
      });
      if (tempItems.length >= 1) {
        c.complete(tempItems.first);
      } else {
        c.completeError('Error classing item');
      }
    }).catchError((error) {
      c.completeError(error);
    });
    return c.future;
  }

  Future<List<Map<String, dynamic>>> getCurrentGalleryItems(String galleryID) {
    var c = Completer<List<Map<String, dynamic>>>();
    globals.firestore.collection('galleries').document(galleryID)
      .collection('items').getDocuments().then((snap) {
        snap.documents.forEach((doc) {
          var tempItem = doc.data;
          tempItem['id'] = doc.documentID;
          currentGalleryItems.add(tempItem);
        });
        c.complete(currentGalleryItems);
    }).catchError((error) {
      c.completeError(error);
    });
    return c.future;
  }

  Future<Map<String, dynamic>> getCurrentGalleryFeed(String galleryID) {
    var c = Completer<Map<String, dynamic>>();
    globals.firestore.collection('galleries').document(galleryID)
      .collection('feed').getDocuments().then((snap) {
        snap.documents.forEach((doc) {
          currentGalleryFeed[doc.documentID] = doc.data;
        });
        c.complete(currentGalleryFeed);
    }).catchError((error) {
      c.completeError(error);
    });
    return c.future;
  }

  Future<Map<String, dynamic>> getCurrentGallery(String galleryID) {
    var c = Completer<Map<String, dynamic>>();
    globals.firestore.collection('galleries').document(galleryID).get().then((doc) {
      if (doc.exists) {
        var tempGallery = doc.data;
        tempGallery['id'] = doc.documentID;
        currentGallery = tempGallery;
        c.complete(currentGallery);
      }
    }).catchError((error) {
      c.completeError(error);
    });
    return c.future;
  }

  Future<bool> userEnabled(String userEmail) {
    var c = Completer<bool>();
    globals.firestore.collection('users').where('email', isEqualTo: userEmail).getDocuments().then((snap) {
      if (snap.documents.isNotEmpty) {
        snap.documents.forEach((doc) {
          var data = doc.data;
          if (data['active'] == null || data['active'] == true) {
            c.complete(true);
          } else {
            c.complete(false);
          }
        });
      }
    }).catchError((error) {
      c.completeError(error);
    });
    return c.future;
  }

  Future<Map<String, dynamic>> signIn(String email, String password) {
    var c = Completer<Map<String, dynamic>>();
    globals.firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((user) {
      globals.firestore.collection('users').document(user.uid).get().then((doc) {
        if (doc.exists) {
          c.complete(doc.data);
        }
      }).catchError((error) {
        c.completeError(error);
      });
    }).catchError((error) {
      c.completeError(error);
    });
    return c.future;
  }

  void tempWriteGallery(
      Map<String, dynamic> gallery,
      Map<String, dynamic> galleryFeed,
      List<Map<String, dynamic>> items,
      Map<String, dynamic> itemFeed
      ) {
    globals.firestore.collection('galleries').add(gallery).then((docRef) {
      String galleryRef = docRef.documentID;
      galleryFeed.forEach((galleryFeedItem, element) {
        globals.firestore.collection('galleries').document(galleryRef)
            .collection('feed').document(galleryFeedItem).setData(element);
      });

      items.forEach((item) {
        globals.firestore.collection('galleries').document(galleryRef)
            .collection('items').add(item).then((docRef2) {
              String itemRef = docRef2.documentID;
              itemFeed.forEach((feedItem, element) {
                globals.firestore.collection('galleries').document(galleryRef)
                    .collection('items').document(itemRef).collection('feed').document(feedItem).setData(element);
              });
        });
      });
    });
  }
}