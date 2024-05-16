import 'dart:ffi';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dua/gsheet/quran_model.dart';
import 'package:dua/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerScreen extends StatefulWidget {
  YoutubePlayerScreen({super.key, required this.quranModel});

  QuranModel quranModel;

  @override
  State<YoutubePlayerScreen> createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  late YoutubePlayerController _controller;
  late bool isInternet = false;

  @override
  void initState() {
    var connectivityResult = (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      isInternet = true;
    }

    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(widget.quranModel.link) ?? 'ZmAT18YakC8',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true,
        // onReady: () => {_controller.play()},
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(widget.quranModel.name),
          ),
          body: Column(
            children: [
              isInternet == false
                  ? Center(
                      child: player,
                    )
                  : Column(
                      children: [
                        const Text("Please check your internet"),
                        IconButton(
                            onPressed: () {
                              _controller = YoutubePlayerController(
                                initialVideoId: YoutubePlayer.convertUrlToId(
                                        widget.quranModel.link) ??
                                    'ZmAT18YakC8',
                                flags: const YoutubePlayerFlags(
                                  autoPlay: true,
                                  mute: false,
                                ),
                              );
                              snake(context, 'Restart click');
                            },
                            icon: const Icon(Icons.restart_alt)),
                      ],
                    )
            ],
          ),
        );
      },
    );
  }
}
