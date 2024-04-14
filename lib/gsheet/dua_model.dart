import 'dart:convert';


class duaModel {

  final int? id;

  final String duaName;

  final String dua;

  final String tarjum;

  const duaModel(
      {this.id,
      required this.duaName,
      required this.dua,
      required this.tarjum});

  /*static duaModel fromJson(Map<String, dynamic> json) => duaModel(
      id: jsonDecode(json[DuaSheetsFiledName.id]),
      duaName: json[DuaSheetsFiledName.duaName],
      dua: json[DuaSheetsFiledName.dua],
      tarjum: json[DuaSheetsFiledName.tarjuma]);*/

  factory duaModel.fromJson(List<dynamic> json) {
     return duaModel(id: jsonDecode(json[0]), duaName: json[1], dua: json[2], tarjum: json[3]);
  }
}

class DuaSheetsFiledName {
  static const String id = 'id';
  static const String duaName = 'duaName';
  static const String dua = 'dua';
  static const String tarjuma = 'tarjuma';
  static List<String> getDuas() => [id, duaName, dua, tarjuma];
}

