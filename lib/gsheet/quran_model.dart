import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'quran_model.g.dart';

@HiveType(typeId: 0)
class QuranModel {
  @HiveField(0)
  int? no;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String link;

  QuranModel({
    this.no,
    required this.name,
    required this.link,
  });

  /*static duaModel fromJson(Map<String, dynamic> json) => duaModel(
      id: jsonDecode(json[DuaSheetsFiledName.id]),
      duaName: json[DuaSheetsFiledName.duaName],
      dua: json[DuaSheetsFiledName.dua],
      tarjum: json[DuaSheetsFiledName.tarjuma]);*/

  factory QuranModel.fromJson(List<dynamic> json) {
    return QuranModel(no: jsonDecode(json[0]), name: json[1], link: json[2]);
  }
}

class DuaSheetsQuranFiledName {
  static const String no = 'no';
  static const String name = 'name';
  static const String link = 'link';

  static List<String> getQuran() => [no, name,link];
}
