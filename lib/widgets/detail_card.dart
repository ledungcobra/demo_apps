import 'package:demo_apps/models/card_item.dart';
import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final CardItem card;
  DetailCard(this.card);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (_) {
        Navigator.of(context).pop();
      },
      child: SimpleDialog(
        key: Key(card.id.toString()),
        backgroundColor: Color.fromRGBO(200, 255, 160, 0.85),
        children: <Widget>[
          Text('Word: ' + card.word),
          SizedBox(height: 10),
          Text('( ' + card.type + ' )'),
          SizedBox(height: 10),
          Text('Meaning: ' + card.meaning),
          SizedBox(height: 10),
          Text('Example: ' + card.example),
          SizedBox(height: 10),
          if (card.synonym != null)
            Text("Synonym: " + card.synonym),
          //Text('Synonym: ' + card.synonym!=null?card.synonym:"  "),
          SizedBox(height: 10),
        ],
        elevation: 20,
        contentPadding: EdgeInsets.all(20),
      ),
    );
  }
}
