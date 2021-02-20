import 'dart:io';
import 'dart:async';
import 'package:news/src/models/item_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NewsDbProvider {
  Database db;

  void init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'items.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (newDb, version) {
        newDb.execute('''
          CREATE TABLE Items
            (
              ${ItemModel.idField} INTEGER PRIMARY KEY,
              ${ItemModel.deletedField} INTEGER,
              ${ItemModel.typeField} TEXT,
              ${ItemModel.byField} TEXT,
              ${ItemModel.timeField} INTEGER,
              ${ItemModel.textField} TEXT,
              ${ItemModel.deadField} INTEGER,
              ${ItemModel.parentField} INTEGER,
              ${ItemModel.kidsField} BLOB,
              ${ItemModel.urlField} TEXT,
              ${ItemModel.scoreField} TEXT,
              ${ItemModel.titleField} TEXT,
              ${ItemModel.descendantsField} INTEGER

            )
        ''');
      },
    );
  } //end of init method

  //m2:
  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      'Items',
      columns: null,
      where: '${ItemModel.idField} = ?',
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  } //end of fetchItem method

  //m3:
  Future<int> addItem(ItemModel item) {
    return db.insert('Items', item.toMap());
  }
} //end of NewsDbProivder
