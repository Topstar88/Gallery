import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class CustomCamera extends StatefulWidget {

  CustomCamera({this.onComplete});

  Function(String detected) onComplete;

  @override
  _CustomCameraState createState() {
    return _CustomCameraState();
  }
}

class _CustomCameraState extends State<CustomCamera>
    with WidgetsBindingObserver {
  CameraController controller;
  List<CameraDescription> cameras;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isDetecting = false;

  String _detected = "";
  double _confidenceThreshold = 0.5;
  int _verifyThreshold = 20;
  int _verifyCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    availableCameras().then((cams) {
      setState(() {
        cameras = cams;
      });
      if (cameras != null && cameras.isNotEmpty) {
        onNewCameraSelected(cameras.first);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (controller != null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        onNewCameraSelected(controller.description);
      }
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.low,
    );

    controller.addListener(() {
      if (mounted) setState(() {});
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      print(e.toString());
    }

    if (mounted) {
      setState(() {
        _verifyCount = 0;
      });

      controller.startImageStream((CameraImage img) {
        if (!isDetecting) {
          isDetecting = true;

          Tflite.runModelOnFrame(
            bytesList: img.planes.map((plane) {
              return plane.bytes;
            }).toList(),
            imageHeight: img.height,
            imageWidth: img.width,
            numResults: 2,
          ).then((recognitions) {
            if (recognitions.length > 0) {
              Map<String, dynamic> _recognition = Map.from(recognitions.first) ?? {};
              if (_detected == _recognition["label"]) {
                if ((_recognition["confidence"] ?? 0) >= _confidenceThreshold) {
                  setState(() {
                    _verifyCount++;
                  });
                  if (_verifyCount >= _verifyThreshold) {
                    controller.stopImageStream().then((result) {
                      Navigator.pop(context);
                      if (widget.onComplete != null) {
                        widget.onComplete(_detected);
                      }
                    }).catchError((error) {

                    });
                  }
                } else {
                  setState(() {
                    _verifyCount--;
                  });
                }
              } else {
                setState(() {
                  _detected = _recognition["label"] ?? "";
                  _verifyCount = 1;
                });
              }
            } else {
              setState(() {
                _verifyCount--;
              });
            }

            isDetecting = false;
          });
        }
      });
    }
  }

  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return new Container();
    } else {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      );
    }
  }

  Widget _captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        FlatButton(
            child: const Icon(Icons.cached, size: 30, color: Colors.white,),
            padding: new EdgeInsets.all(0),
            onPressed: () {
              if (cameras != null && cameras.isNotEmpty) {
                cameras.forEach((description) {
                  if (description != controller.description) {
                    onNewCameraSelected(description);
                  }
                });
              }
            }
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _cameraPreviewWidget(),
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: new EdgeInsets.only(left: 20, right: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2.5),
                      child: LinearProgressIndicator(
                        value: _verifyCount.toDouble() / _verifyThreshold.toDouble(),
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
                        backgroundColor: Colors.grey,
                      ),
                    ),
                  ),
                  new Container(height: 20),
                  _captureControlRowWidget(),
                  new Container(height: 40)
                ],
              )
          ),
        )
      ],
    );
  }
}