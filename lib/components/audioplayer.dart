import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:intl/intl.dart';

import '../globals.dart' as globals;
import '../components/gallery-views.dart';

class CustomAudioPlayer extends StatefulWidget {
  CustomAudioPlayer();

  @override
  _CustomAudioPlayerState createState() => _CustomAudioPlayerState();
}

class _CustomAudioPlayerState extends State<CustomAudioPlayer> {

  double _value = 0;

  AudioPlayer _audioPlayer;
  int _duration = 0;

  StreamSubscription<Duration> _streamSubscription1;
  StreamSubscription<Duration> _streamSubscription2;

  @override
  void initState() {
    super.initState();

    _audioPlayer = AudioPlayer();
    _audioPlayer.setUrl("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3").then((result) {
      print(result);
    }).catchError((error) {
      print(error);
    });

    _streamSubscription1 = _audioPlayer.onDurationChanged.listen((Duration d) {
      print('Max duration: $d');
      setState(() => _duration = d.inSeconds);
    });

    _streamSubscription2 = _audioPlayer.onAudioPositionChanged.listen((Duration d) {
      double _percent = d.inSeconds / max(d.inSeconds, _duration);
      setState(() {
        _value = _percent;
      });
    });
  }

  @override
  void dispose() {
    _streamSubscription1.cancel();
    _streamSubscription2.cancel();
    _audioPlayer.dispose();

    super.dispose();
  }

  String _getString(int time) {
    var _format = NumberFormat("##");
    return "${Duration(seconds: time).inMinutes.remainder(60)}:${_format.format(Duration(seconds: time).inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    var _position = (_duration * _value).toInt();

    return GalleryViews.viewCard(
        padding: new EdgeInsets.fromLTRB(15, 30, 15, 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Podcast / Audio",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: globals.titleColor
              ),
              textAlign: TextAlign.left,
            ),
            new Container(height: 20),
            Text(
              "Podcast Description",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: globals.textColor
              ),
              textAlign: TextAlign.left,
            ),
            new Container(height: 20),
            new Container(
              decoration: BoxDecoration(
                color: globals.lightGray,
                borderRadius: BorderRadius.circular(25)
              ),
              child: Row(
                children: <Widget>[
                  IconButton(
                    padding: new EdgeInsets.all(0),
                    icon: Icon(
                      _audioPlayer.state == AudioPlayerState.PLAYING
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.grey,
                    ),
                    onPressed: () async {
                      if (_audioPlayer.state == AudioPlayerState.PLAYING) {
                        await _audioPlayer.pause();
                      } else {
                        await _audioPlayer.resume();
                      }
                      setState(() {

                      });
                    },
                  ),
                  Text(
                    "${_getString(_position)} / ${_getString(_duration)}",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                    ),
                  ),
                  new Container(width: 5),
                  Expanded(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.blue,
                          inactiveTrackColor: Colors.grey[600],
                          trackHeight: 3.0,
                          thumbColor: Colors.grey,
                          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
                          overlayColor: Colors.blue.withAlpha(60),
                          overlayShape: RoundSliderOverlayShape(overlayRadius: 10.0),
                        ),
                        child: Slider(
                            value: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = value;
                              });
                              _audioPlayer.seek(Duration(seconds: (_value * _duration).toInt()));
                            }
                        ),
                      )
                  ),
                  IconButton(
                    padding: new EdgeInsets.all(0),
                    icon: Icon(
                      Icons.volume_up,
                      color: Colors.grey,
                    ),
                    onPressed: () {

                    },
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}