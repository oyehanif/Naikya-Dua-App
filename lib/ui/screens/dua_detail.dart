import 'dart:io';
import 'dart:typed_data';

import 'package:dua/hive/dua_hive.dart';
import 'package:dua/hive/dua_hive_model.dart';
import 'package:dua/main.dart';
import 'package:dua/route/route.dart';
import 'package:dua/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

const String url =
    "https://drive.google.com/uc?export=download&id=1QJPBcOLPv9rgDTNVYTxaJsOUH8OMdhKB";

// const url = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3';

String getDirectDownloadLink(String shareableLink) {
  // Split the shareable link by "/"
  List<String> parts = shareableLink.split('/');

  // Extract the file ID from the link
  String fileId = parts[parts.length - 2];
  // Construct the direct download link
  return 'https://drive.google.com/uc?export=download&id=$fileId';
}

class DuaDetailScreen extends StatefulWidget {
  DuaDetailScreen({super.key, required this.type});

  MyDuaDetailCustomType type;

  @override
  State<DuaDetailScreen> createState() => _DuaDetailScreenState();
}

class _DuaDetailScreenState extends State<DuaDetailScreen> {
  final audioPlayer = AudioPlayer();
  final controller = ScreenshotController();

  @override
  void initState() {
    super.initState();
    // audioPlayer = AudioPlayer();
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
    var color = widget.type.model.isFav ? Colors.red : Colors.black;
    return Scaffold(
      appBar: AppBar(
        title: Hero(tag: 'text', child: Text(widget.type.model.duaName)),
        actions: [
          PopupMenuButton<String>(
            onSelected: (s) async {
              final image = await controller.captureFromWidget(
                  ForScreenShot(
                    model: widget.type.model,
                    size: size,
                    color: color,
                    isForScreenshot: true,
                    onPress: () {},
                    onShare: () {},
                  ),
                  context: context);
              if (image == null) return;
              String? result = await saveImage(image, context);
              result != null
                  ? {
                      if (context.mounted)
                        {
                          snake(context,
                              'Download Successfully. Please check you gallary!')
                        }
                    }
                  : snake(context,
                      'Please Grade the permission for use this feature');
            },
            itemBuilder: (BuildContext context) {
              return {'Save'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Row(
                    children: [
                      const Icon(Icons.download_outlined),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(choice),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: DuaDetailWidget(
          model: widget.type.model,
          size: size,
          color: color,
          // isForScreenshot: true,
          onPress: () {
            DuaHive.updateDua(
                widget.type.model.id!,
                DuaHiveModel(
                    id: widget.type.model.id,
                    duaName: widget.type.model.duaName,
                    dua: widget.type.model.dua,
                    tarjum: widget.type.model.tarjum,
                    isFav: !widget.type.model.isFav));
            setState(() {
              var model = DuaHiveModel(
                  id: widget.type.model.id,
                  duaName: widget.type.model.duaName,
                  dua: widget.type.model.dua,
                  tarjum: widget.type.model.tarjum,
                  isFav: !widget.type.model.isFav);
              widget.type = MyDuaDetailCustomType(
                  model: model,
                  isQalmas: widget.type.isQalmas,
                  isClick: widget.type.isClick);
            });
            widget.type.isClick.call();
          },
          onShare: () async {
            final image = await controller.captureFromWidget(
                ForScreenShot(
                  model: widget.type.model,
                  size: size,
                  color: color,
                  isForScreenshot: true,
                  onPress: () {},
                  onShare: () {},
                ),
                context: context);
            if (image == null) return;
            await saveAndShare(image);
          }),
    );
  }
}

class DuaDetailWidget extends StatelessWidget {
  DuaDetailWidget({
    super.key,
    required this.model,
    required this.size,
    required this.onPress,
    required this.color,
    required this.onShare,
    this.isQalmas = false,
    this.isForScreenshot = false,
  });

  final DuaHiveModel model;
  final Size size;
  final Function() onPress;
  final Function() onShare;
  final Color color;

  bool isQalmas = false;
  bool isForScreenshot = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  isForScreenshot
                      ? Column(
                          children: [
                            Text(model.duaName,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green)),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        )
                      : const SizedBox(height: 20),
                  const Text('Read This Before When We Are Eating Some',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                          model.dua,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(model.tarjum, style: const TextStyle(fontSize: 20)),

                  ///This Textview only for give the space become of content overlap
                  SizedBox(
                    height: size.height * 0.1,
                  )
                ],
              ),
            ),
          ),
          isForScreenshot
              ? const SizedBox(
                  height: 0,
                )
              : Positioned(
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
                          if (!isQalmas)
                            IconButton(
                              onPressed: () {
                                onPress();
                              },
                              icon: const Icon(
                                Icons.favorite,
                              ),
                              color: color,
                            ),
                          IconButton(
                              onPressed: () {
                                onShare();
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
    );
  }
}

/// Below Widget just for Screenshot
class ForScreenShot extends StatelessWidget {
  ForScreenShot(
      {super.key,
      required this.model,
      required this.size,
      required this.onPress,
      required this.color,
      required this.onShare,
      this.isForScreenshot = false});

  final DuaHiveModel model;
  final Size size;
  final Function() onPress;
  final Function() onShare;
  final Color color;

  bool isForScreenshot = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.white,
      child: Padding(
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
                    isForScreenshot
                        ? Column(
                            children: [
                              Text(model.duaName,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green)),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          )
                        : const SizedBox(height: 20),
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
                            model.dua,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(model.tarjum, style: const TextStyle(fontSize: 20)),

                    ///This Textview only for give the space become of content overlap
                    SizedBox(
                      height: size.height * 0.1,
                    )
                  ],
                ),
              ),
            ),
            isForScreenshot
                ? const SizedBox(
                    height: 0,
                  )
                : Positioned(
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
                                onPress();
                              },
                              icon: const Icon(
                                Icons.favorite,
                              ),
                              color: color,
                            ),
                            IconButton(
                                onPressed: () {
                                  onShare();
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

Future saveAndShare(Uint8List imageSnap) async {
  final directory = await getApplicationDocumentsDirectory();
  final image = File('${directory.path}/flutter.png');
  image.writeAsBytesSync(imageSnap as List<int>);
  await Share.shareXFiles([XFile(image.path)],
      text: 'Want this type of Awesome Then Download NAIKYA');
}

Future<String?> saveImage(Uint8List image, BuildContext context) async {
  final permission = await Permission.storage;

  if(await checkPermissionStatus()){
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = 'dua_$time';

    final result = await ImageGallerySaver.saveImage(image, name: name);
    return result['filePath'];
  }else{
    [Permission.storage].request();
    final result = await permission.status;

    if (result.isGranted) {
      final time = DateTime.now()
          .toIso8601String()
          .replaceAll('.', '-')
          .replaceAll(':', '-');
      final name = 'dua_$time';

      final result = await ImageGallerySaver.saveImage(image, name: name);
      return result['filePath'];
    } else if (result.isDenied) {
      // Permission is denied
    } else if (result.isPermanentlyDenied) {
      if (context.mounted) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Allow app to acess your contacts list ?'),
            content: const Text(
                'You need to allow contact access in parameters for use your contacts list in the app'),
            actions: <Widget>[
              // if user deny again, we do nothing
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Don\'t allow'),
              ),

              // if user is agree, you can redirect him to the app parameters :)
              TextButton(
                onPressed: () {
                  openAppSettings();
                  Navigator.pop(context);
                },
                child: const Text('Allow'),
              ),
            ],
          ),
        );
      }
    }
  }
}

Future<bool> checkPermissionStatus() async {
  final permission = Permission.storage;
  return await permission.status.isGranted;
}
