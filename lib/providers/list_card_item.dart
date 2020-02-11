
import 'dart:core';

import '../models/card_item.dart';
import 'package:flutter/foundation.dart';
import '../DBHelpers/database_helper.dart';

import '../models/data.dart' as data;


class ListCardItem with ChangeNotifier {
  String category;
  static String tableName = 'listCardItem';
  Map<String,List<CardItem>> _items = data.items;  
  Map<String, List<CardItem>> get map {
    return _items;
  }
  DatabaseHelper get db {
    return DatabaseHelper()..setTableName(ListCardItem.tableName);
  }
  List<CardItem> listAtKey(String key,TypeOfCard type) {


    return [..._items[key].where((card)=>card.typeOfCard == type).toList()];
  }
  Future<void> fetchSpecificTypeOfCard(TypeOfCard type) async {
    final list = await this.db.getSpecificCard(type);
    final newItems = parseDataAndReplace(list);
    _items = newItems;
  }
  Future<void> fetchAllData() async {
    final list = await this.db.getAllCard();
    final newItems = parseDataAndReplace(list);
    _items = newItems;
  }

  Map parseDataAndReplace(List list) {
    Map<String, List<CardItem>> newMap = {};

    list.forEach((item) {
      final card = CardItem.fromMap(item);
      if (newMap.containsKey(card.topic)) {
        newMap[card.topic].add(card);
      } else {
        newMap.putIfAbsent(card.topic, () => [card]);
      }
    });
    return newMap;
  }

  List<CardItem> get items {
    List<CardItem> _result = [];
    int count = 0;
    _items.forEach((key, list) {
      list.forEach((item) {
        if (item.word != '') {
          count++;
        }
      });
    });
    _items.forEach((key, list) {
      _result += [...list];
    });
    return _result;
  }

  List<String> get topic {
    return _items.keys.toList();
  }

  Future<void> remove(CardItem card) async {
    _items[card.topic].removeWhere((item) => item.id == card.id);
    if (_items[card.topic].length == 0) {
      _items.remove(card.topic);
    }
    await db.deleteCard(card.id);
    notifyListeners();
  }

  Future<void> addToLearn(CardItem card) async {
    await _addToSpecificType(TypeOfCard.Learn, card);

  }
  Future<void> addToKnew(CardItem card) async{
    await _addToSpecificType(TypeOfCard.Knew, card);

  }
  Future<void> addToAlmostMaster(CardItem card) async{
    await _addToSpecificType(TypeOfCard.AlmostMaster, card);

  }
  Future<void> addToReVise(CardItem card) async{
    await _addToSpecificType(TypeOfCard.Revise, card);
  }
  Future<void> addToMaster(CardItem card) async{
    await _addToSpecificType(TypeOfCard.Master, card);

  }
  Future<void> _addToSpecificType(TypeOfCard type, CardItem card) async {
    card.typeOfCard = type;
    final index = _items[card.topic].indexWhere((item) => item.id == card.id);
    _items[card.topic][index] = card;
    await db.updateCard(card);
    //notifyListeners();
  }

  
}
