import 'package:demo_apps/widgets/card_item.dart';
import 'package:flutter/material.dart';
import '../models/card_item.dart' as ci;


class ScrollListCardItem extends StatelessWidget {
  //const ScrollListCardItem({Key key}) : super(key: key);
  final List<ci.CardItem> listCard;


  ScrollListCardItem(this.listCard);


  @override
  Widget build(BuildContext context) {
   

    return SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemBuilder: (ctx,i){
            return Column(
            children: <Widget>[
              CardItem(listCard[i]),             
            ],
          );},          
          itemCount: listCard.length,
        ),

      ),
    );
  }
}
