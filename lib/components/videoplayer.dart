import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

import '../globals.dart' as globals;
import '../components/gallery-views.dart';

class CustomVideoPlayer extends StatefulWidget {
  CustomVideoPlayer();

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {

  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.asset("assets/images/big_buck_bunny.mp4");

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _video = globals.database.currentItemFeed["video"] ?? {};
    return GalleryViews.viewCard(
        padding: new EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chewie(
              controller: _chewieController,
            ),
            Text(
              _video["title"] ?? "",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: globals.titleColor
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              _video["description"] ?? "",
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
}