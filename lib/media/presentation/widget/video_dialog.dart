import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDialog extends StatelessWidget {
  String? videoID;
  VideoDialog(this.videoID);
  @override
  Widget build(BuildContext context) {
    var _controller = YoutubePlayerController(
        initialVideoId: videoID!, flags: YoutubePlayerFlags(autoPlay: true));
    var _player = YoutubePlayer(controller: _controller);

    return Dialog(
      backgroundColor: Colors.black.withOpacity(0.4),
      insetAnimationDuration: Duration(milliseconds: 400),
      insetPadding: EdgeInsets.all(0),
      child: Hero(
        tag: videoID!,
        child: YoutubePlayerBuilder(
          player: _player,
          builder: (context, player) {
            return player;
          },
        ),
      ),
    );
  }
}
