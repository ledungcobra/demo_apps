import 'package:demo_apps/models/card_item.dart';
import 'package:demo_apps/widgets/detail_card.dart';
import 'package:flutter/material.dart';

class DemoItem extends StatelessWidget {
  final CardItem card;
  DemoItem(this.card);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              width: 20,
              height: MediaQuery.of(context).size.height * 0.3 - 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
                color: Color.fromRGBO(230, 230, 230, 1),
                border: Border.all(
                    width: 2, color: Color.fromRGBO(230, 230, 230, 1)),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: () async {
           await showDialog(builder: (ctx)=>DetailCard(card),context: context);

          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Center(
              child: Text(card.word,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 40)),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: Color.fromRGBO(230, 230, 230, 0.35),
                border: Border.all(
                    width: 1, color: Color.fromRGBO(230, 230, 230, 1))),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Column(children: [
          SizedBox(
            height: 20,
          ),
          Container(
            width: 20,
            height: MediaQuery.of(context).size.height * 0.3 - 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
              ),
              color: Color.fromRGBO(230, 230, 230, 0.35),
              border:
                  Border.all(width: 2, color: Color.fromRGBO(230, 230, 230, 1)),
            ),
          ),
        ])
      ],
    );
  }
}
