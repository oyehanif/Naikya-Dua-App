import 'dart:async';
import 'dart:io';

import 'package:dua/ui/screens/dua_detail.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<String> fetchAudio() async {
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  File tempFile = File('$tempPath/sonekidua');

  http.Response response = await http.get(Uri.parse(
      "https://drive.google.com/uc?download=view&id=1QJPBcOLPv9rgDTNVYTxaJsOUH8OMdhKB"));
  // todo - check status
  await tempFile.writeAsBytes(response.bodyBytes, flush: true);

  return tempFile.path;
}

Future<String> downloadFile() async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = new File('$dir/sonekidua');
  // var request = await http.get(Uri.parse("https://drive.google.com/uc?download=view&id=1QJPBcOLPv9rgDTNVYTxaJsOUH8OMdhKB" ));
  var request = await http.get(Uri.parse(url));
  var bytes = await request.bodyBytes; //close();
  await file.writeAsBytes(bytes);
  print("File : ${file.path}");
  return file.path;
}
