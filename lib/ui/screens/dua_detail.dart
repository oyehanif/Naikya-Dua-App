
import 'package:dua/hive/dua_hive.dart';
import 'package:dua/hive/dua_hive_model.dart';
import 'package:dua/main.dart';
import 'package:dua/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

const String url =
    "https://drive.google.com/uc?export=download&id=1QJPBcOLPv9rgDTNVYTxaJsOUH8OMdhKB";

// const url = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3';

class DuaDetailScreen extends StatefulWidget {
  DuaDetailScreen({super.key, required this.model});

  DuaHiveModel model;

  @override
  State<DuaDetailScreen> createState() => _DuaDetailScreenState();
}

class _DuaDetailScreenState extends State<DuaDetailScreen> {
  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    // audioPlayer = AudioPlayer();
    print("Here Data from dualist :${widget.model.isFav}");
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> play() async {
    try {
      // audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(
      //     // "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3"
      //   url
      //   )));
      audioPlayer.setAudioSource(AudioSource.file(test));
      audioPlayer.play();
      // await audioPlayer.play(UrlSource(url));
    } catch (e) {
      print("Here : $e");
    }

    // print(" Here Duration ${audioPlayer.getDuration()}");
  }

  Future<void> pause() async {
    await audioPlayer.pause();
  }

  Future<void> stop() async {
    await audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var color = widget.model.isFav ? Colors.red : Colors.black;
    return Scaffold(
      appBar: AppBar(
        title: Hero(tag: 'text', child: Text(widget.model.duaName)),
        actions: [
          PopupMenuButton<String>(
            onSelected: (s) {},
            itemBuilder: (BuildContext context) {
              return {'Save', 'Share'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            SizedBox(
              height: size.height * .9,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Read This Before When We Are Eating Some',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            widget.model.dua,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(widget.model.tarjum,
                        style: const TextStyle(fontSize: 20)),

                    ///This Textview only for give the space become of content overlap
                    SizedBox(
                      height: size.height * 0.1,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Container(
                    width: size.width,
                    height: size.height * 0.07,
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.green),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // IconButton(
                        //     onPressed: () {
                        //       play();
                        //       snake(context,
                        //           'Audio feature is currently under construction! Please Stay tune');
                        //     },
                        //     icon: const Icon(Icons.play_circle)),
                        IconButton(
                          onPressed: () {
                            snake(context,
                                'Save feature is currently under construction! Please Stay tune ${widget.model.isFav}.');
                            DuaHive.update(
                                widget.model.id!,
                                DuaHiveModel(
                                    id: widget.model.id,
                                    duaName: widget.model.duaName,
                                    dua: widget.model.dua,
                                    tarjum: widget.model.tarjum,
                                    isFav: !widget.model.isFav));
                            setState(() {
                              widget.model = DuaHiveModel(
                                  id: widget.model.id,
                                  duaName: widget.model.duaName,
                                  dua: widget.model.dua,
                                  tarjum: widget.model.tarjum,
                                  isFav: !widget.model.isFav);
                            });
                          },
                          icon: const Icon(
                            Icons.favorite,
                          ),
                          color: color,
                        ),
                        IconButton(
                            onPressed: () {
                              snake(context,
                                  'Share feature is currently under construction! Please Stay tune');
                            },
                            icon: const Icon(Icons.share)),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

String getDirectDownloadLink(String shareableLink) {
  // Split the shareable link by "/"
  List<String> parts = shareableLink.split('/');

  // Extract the file ID from the link
  String fileId = parts[parts.length - 2];
  // Construct the direct download link
  return 'https://drive.google.com/uc?export=download&id=$fileId';
}
