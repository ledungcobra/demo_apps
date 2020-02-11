import 'package:flutter/foundation.dart';

enum TypeOfCard {
  Init,
  Learn,
  Knew,
  Revise,
  AlmostMaster,
  Master,
}

class CardItem {
  String word = ' ';
  String type = ' ';
  String meaning = ' ';
  String example = ' ';
  int id;
  String imageUrl = ' ';
  String synonym = ' ';
  String anonym = '';
  String topic = ' ';
  var typeOfCard = TypeOfCard.Init;
  CardItem({
    @required this.word,
    @required this.type,
    @required this.example,
    @required this.meaning,
    this.topic,
    this.id,
    this.imageUrl,
    this.synonym,
    this.anonym,
  });

  Map<String, dynamic> toMap() {
    return {
      'topic': topic,
      'word': word,
      'type': type,
      'example': example,
      'meaning': meaning,
      if (id != null) 'id': id,
      'imageUrl': imageUrl,
      if (synonym != null) 'synonym': synonym,
      if (anonym != null) 'anonym': anonym,
      'typeOfCard': typeOfCard.index
    };
  }

  CardItem.fromMap(Map<String, dynamic> card) {
    this.id = card['id'];
    this.example = card['example'];
    this.imageUrl = card['imageUrl'];
    this.meaning = card['meaning'];
    this.type = card['type'];
    this.word = card['word'];
    this.anonym = card['anonym'];
    this.synonym = card['synonym'];
    this.topic = card['topic'];
    switch (card['typeOfCard']) {
      case 0:
        typeOfCard = TypeOfCard.Init;
        break;
      case 1:
        typeOfCard = TypeOfCard.Learn;

        break;
      case 2:
        typeOfCard = TypeOfCard.Knew;

        break;
      case 3:
        typeOfCard = TypeOfCard.Revise;
        break;
      case 4:
        typeOfCard = TypeOfCard.AlmostMaster;

        break;
      case 5:
        typeOfCard = TypeOfCard.Master;

        break;
    }
  }
}
