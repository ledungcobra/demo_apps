import 'dart:io';

import 'package:demo_apps/models/card_item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

class DatabaseHelper {
  var _tableName = '';
  var _fileName  = '';
  final columnId = 'id';
  final columnWord = 'word';
  final columnMeaning = 'meaning';
  final columnExample = 'example';
  final columnType = 'type';
  final columnImageUrl = 'imageUrl';
  final columnSynonym = 'synonym';
  final columnAnonym = 'anonym';
  final columnTopic = 'topic';
  final columnTypeOfCard = 'typeOfCard';

  static Database _db;
  DatabaseHelper([this._fileName = 'FlashCard.db']);

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDb();
    return _db;
  }

  _initDb() async {
    Directory documentDir = await getApplicationDocumentsDirectory();
    String pathDir = path.join(documentDir.path,_fileName );
    var ourDb = await openDatabase(pathDir, onCreate: (db, version) {
      final script = 'CREATE TABLE $_tableName($columnId INTEGER PRIMARY KEY,$columnWord TEXT, $columnMeaning TEXT,$columnExample TEXT,$columnType TEXT,$columnImageUrl TEXT,$columnSynonym TEXT,$columnAnonym TEXT,$columnTopic TEXT,$columnTypeOfCard INTEGER)';
      return db.execute(script);
    }, version: 2);
    return ourDb;
  }

  Future<int> saveCard(CardItem card) async {
    var dataBase = await this.db;
    int res = await dataBase.insert(_tableName, card.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }
  Future<List> getSpecificCard(TypeOfCard type) async{
    final dataBase = await this.db;

    final maps = await dataBase.query(_tableName,columns: [columnId,columnWord,columnMeaning,columnExample,columnType,columnImageUrl,columnAnonym,columnTopic,columnTypeOfCard],where: "$columnTypeOfCard = ?",whereArgs: [type.index]); 
    //debug

    return maps;

  }

  Future<List> getAllCard() async {
    var database = await this.db;
    final result = await database.rawQuery('SELECT * FROM $_tableName');
    return result.toList();
  }

  Future<int> deleteCard(int cardId) async {
    var database = await this.db;
    return database.delete(_tableName, where: 'id = ?', whereArgs: [cardId]);
  }

  Future<int> updateCard(CardItem card) async {
    var database = await this.db;
    return await database
        .update(_tableName, card.toMap(), where: 'id = ?', whereArgs: [card.id]);
        
  }

  setTableName(String tableName) {
    this._tableName = tableName;
  }

  Future<void> deleteFile() async {
    Directory documentDir = await getApplicationDocumentsDirectory();
    String pathDir = path.join(documentDir.path, 'FlashCard.db');
    await deleteDatabase(pathDir);
  }
}
