import 'package:dua/gsheet/dua_model.dart';
import 'package:gsheets/gsheets.dart';

class DuaSheetsApi {
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "dua-app-408315",
  "private_key_id": "819bd2e1326f68e9d8814b27103817f276881ed9",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDNTi5sEibJDvwK\nxMQQFhJ9S1mrewIxMPRmwEyOFo6J/UEgvAgqRqep/7GSRp9uzZ8yLyLGZzVp4Dw3\ny4qKMgc0tFJdIS/sFYL14f4wr84k3qj9GQgt2rifTh/3RtQd9AYRNlTisKr5hdBQ\nsCJidlzr27BnFG1M3YNe5EvrCB1ciuZGYNA5JqdVmsHKN8uyGHGMULp5fIo37DFl\nEZSqkYrFtYNpsFZ13OdSmGKjZrlqe5OZRwQzp2CdpMG3QoLHy0hrAZjlX3Paehm5\nJeo9JfO0bOMIN4YYi28LgnbvmALG6hZi80oshjMYXbpCf59gubE++Hh3hJ+CenUC\nv8BBhxorAgMBAAECggEABeGu/8aXWNw2iUJw0XsoZXGCrKB2BB3Aaq8ooktwIvDf\n7EWmwDtM81hRaHzgdWaroF7sUp3DUHitkPWiTuo2/aIK2AMq4csN+OhUBWYL9E9y\nrOmKK/IfpuSwkr9zNTZ39AdH8ESaaVKVkLIzEfoNGG6vQ4y4wuJ3sIC+0gll+fAt\nm5LMZ0+jyiwnvRttDeWcSY4ihSp6ZOFjU1SUA/+z/ExYD7IjvYFMZbFRYqat816k\n1QX2ZdX/MtDI/aGVlgChjvp/NZW/aUUdPPlvXuR9fzQBzok9kC5qzJ6U1yE+1Atc\nvtpoloK7l1BPiB89kXFWYbbg4kZ2XhCkISMEQ1mUjQKBgQDr4fRu0nbQg8atMW2r\nfYL+jdpfaYFE0T9R1mLDBzNF9nyFcuQPqSz40L8ogpVdqcgXlSzyu3asHAxDprJL\n94V/8u3HQMTwdqEhFVNGcNpBfM7v7wxHhrNTsJ/otg/1pdLFU/tQ5N0o3jiha42F\nv98J1kgXUbnSmpz9xf0WXStctwKBgQDe0KGPioqZ9tr6cyJSv29zPn1vitWhQMyd\ndxtxotx22a1AObga8VxLF1QjKD14pw3bpNHy9EjVqkyAvCbI5wOCB06hBcKIbsCQ\nLr3MlzSq9tl3N5GhgN7+yMzzByNLD7+aYt875g6bo8M3u4B+TIiYIWjq+mKbv0yi\nSVpeTaSiLQKBgQCquOJZ51f5OLbuGS1ABlpt9KtNjSXzceL7T0gx0Z9Jjsm3KF1p\n/E7BUwxXvJNws/ZPIzfiAs40aSRzPk4jb2WfImr4YKdpRuL999pKzFkbNsLroz9m\n8VYPR3GlU0gfycHP8iWd+dcbwiKIqjhGyoUaMI4C2rK8fA0OG2M+8XX15wKBgQDQ\nX1oH7C9MZ1BIUe3yZrcqlnEmJDc+82OniyDuN7lnqJBedNwYzklarDlyG4rJT6kl\nFNGHHS8UKowbBFpdHbXpHz5IViOkBbct35h+QZXuoKWk2SHnYKaqrU0FplI6O0Mb\ndYWA9dgJc6/4afBzrM09QFlnDruzHcbkKidJ8+CYDQKBgF/IZiEMNIn82gnDmyGC\nbKxq8CvcWmWn/zPdv83muxdLKmm0or59Dq7pxJFLuj1teZXAghiMok5v7PJtJnVW\nLzoT8FAirRagA+A4A3B5O0ptJPNzrtnrLpL/nwleJSSqKnpb6P2bNIyHGDV6e/4l\n3MoIXzSi3mP9jFnebkd1te9V\n-----END PRIVATE KEY-----\n",
  "client_email": "dua-app@dua-app-408315.iam.gserviceaccount.com",
  "client_id": "117770429320298694000",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/dua-app%40dua-app-408315.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
  ''';
  static final _spreadsSheetId = '1JEw0AdDhcA84AbMWiKp3eYuKBvKMGzGF1aOyVSBG48Q';

  static final _gsheet = GSheets(_credentials);

  static Worksheet? userSheet;
  static Worksheet? qalmasSheet;

  static Future init() async {
    final spreadsheet = await _gsheet.spreadsheet(_spreadsSheetId);
    userSheet = await _getWorkSheet(spreadsheet, title: 'dua');
    qalmasSheet = await _getWorkSheet(spreadsheet, title: 'qalmas');

    try {
      final firstRow = DuaSheetsFiledName.getDuas();
      userSheet!.values.insertRow(1, firstRow);
      qalmasSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Here : Error From Fist Row $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<List<duaModel>> getAllDua() async {
    if (userSheet == null) return <duaModel>[];

    final duas = await userSheet!.values.allRows();
    duas.removeAt(0);
    return duas.map(duaModel.fromJson).toList();
  }

  static Future<List<duaModel>> getAllQalmas() async {
    if (qalmasSheet == null) return <duaModel>[];

    final qalmas = await qalmasSheet!.values.allRows();
    qalmas.removeAt(0);
    return qalmas.map(duaModel.fromJson).toList();
  }
}
