import 'dart:convert';

class ItemModel {
  static const String idField = 'id';
  static const String deletedField = 'deleted';
  static const String typeField = 'type';
  static const String byField = 'by';
  static const String timeField = 'time';
  static const String textField = 'text';
  static const String deadField = 'dead';
  static const String parentField = 'parent';
  static const String kidsField = 'kids';
  static const String urlField = 'url';
  static const String scoreField = 'score';
  static const String titleField = 'title';
  static const String descendantsField = 'descendants';

  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final String score;
  final String title;
  final int descendants;

  ItemModel({
    this.by,
    this.dead,
    this.deleted,
    this.descendants,
    this.id,
    this.kids,
    this.parent,
    this.score,
    this.text,
    this.time,
    this.title,
    this.type,
    this.url,
  }); //end of ItemModel constructor 1

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ItemModel(
      by: json[byField],
      dead: json[deadField],
      deleted: json[deletedField],
      descendants: json[descendantsField],
      id: json[idField],
      kids: json[kidsField],
      parent: json[parentField],
      score: json[scoreField],
      text: json[textField],
      time: json[timeField],
      title: json[titleField],
      type: json[typeField],
      url: json[urlField],
    );
  } //end of ItemModel.fromJson constructor 2

  factory ItemModel.fromDb(Map<String, dynamic> record) {
    if (record == null) return null;
    return ItemModel(
      by: record[byField],
      dead: record[deadField] == 1,
      deleted: record[deletedField] == 1,
      descendants: record[descendantsField],
      id: record[idField],
      kids: jsonDecode(record[kidsField]),
      parent: record[parentField],
      score: record[scoreField],
      text: record[textField],
      time: record[timeField],
      title: record[titleField],
      type: record[typeField],
      url: record[urlField],
    );
  } //end of ItemModel.fromDb constructor 3

  Map<String, dynamic> toMap() {
    return {
      idField: id,
      deletedField: deleted ? 1 : 0,
      typeField: type,
      byField: by,
      timeField: time,
      textField: text,
      deadField: dead ? 1 : 0,
      parentField: parent,
      kidsField: jsonEncode(kids),
      urlField: url,
      scoreField: score,
      titleField: title,
      descendantsField: descendants,
    };
  } //end of toJson method
} //end of ItemModel class
