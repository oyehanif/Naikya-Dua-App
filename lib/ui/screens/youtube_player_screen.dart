import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerScreen extends StatefulWidget {
  const YoutubePlayerScreen({super.key});

  @override
  State<YoutubePlayerScreen> createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'ZmAT18YakC8',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
        // onReady: () => {_controller.play()},
        ),
        builder: (context, player) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("Youtube Player"),
              ),
              body: Center(child: player));
        });
  }
}
