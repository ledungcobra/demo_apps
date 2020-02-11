import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:demo_apps/screens/larger_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import '../models/card_item.dart' as ci;
import 'package:provider/provider.dart';
import '../providers/list_card_item.dart';
import 'package:http/http.dart' as http;
import 'dart:core';

// import '../DBHelpers/database_helper.dart';

class CardItem extends StatefulWidget {
  //const CardItem({Key key}) : super(key: key);

  final ci.CardItem data;

  CardItem(this.data);

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  var isExpanded = false;
  var isShowedExampleMeaning = false;
  var isInit = false;              
  String meaningExample;
  Future<void> getData() async {
    String translateUrl =
        'https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20200127T151201Z.1f719ecd3971af88.a8b21aa6885b4024e61fd6a927410179f6b933a0&text=${widget.data.example}&lang=vi';

    try {
      final responseTranslate = await http.get(translateUrl);

     // print('----------------------');

      // meaningExample = json.decode(responseTranslate.body)[0][0][0];
      meaningExample = json.decode(responseTranslate.body)['text'][0];
    } catch (error) {
      //print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    var duration2 = Duration(seconds: 1);

    return FutureBuilder(
      future: !isInit ? getData() : null,
      builder: (_, snapshot) {
        var meaningContainer = AnimatedContainer(
          decoration: BoxDecoration(
            backgroundBlendMode: BlendMode.exclusion,
            color: Colors.black.withOpacity(0.25),
          ),
          width: double.infinity,
          height: !isExpanded ? 0 : (isShowedExampleMeaning ? 70 : 0),
          child: Center(
            child: AutoSizeText(
              meaningExample != null ? meaningExample : '',
              style: TextStyle(fontSize: isShowedExampleMeaning ? 25 : 0),
              softWrap: true,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
            ),
          ),
          duration: Duration(milliseconds: 300),
        );
        var meaningWord = AnimatedContainer(
          decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 180, 0.7),
              borderRadius: BorderRadius.circular(10)),
          width: double.infinity,
          duration: Duration(milliseconds: 300),
          height: isExpanded ? 30 : 0,
          //Meaning
          child: Text(
            widget.data.meaning,
            textAlign: TextAlign.center,
          ),
        );
        var cardWord = Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 8,
            ),
            Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    border: Border.all(width: 1, color: Colors.red),
                  ),
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: SelectableText(
                    widget.data.word,
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
                FlatButton.icon(
                  icon:
                      Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  label: Text(
                    isExpanded ? 'Hide meaning' : 'Show meaning',
                    style: TextStyle(color: Colors.purple),
                  ),
                ),
              ],
            ),
          ],
        );
        var exampleContainer = AnimatedContainer(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 180, 0.8),
            boxShadow: [
              BoxShadow(color: Colors.black38, blurRadius: 2.0),
            ],
          ),
          duration: Duration(milliseconds: 700),
          height: isExpanded ? 50 : 0,
          child: Text(
            widget.data.example,
            textAlign: TextAlign.center,
          ),
        );
        return snapshot.connectionState == ConnectionState.waiting && isInit
            ? CircularProgressIndicator()
            : Dismissible(
                secondaryBackground: Container(
                  decoration: BoxDecoration(color: Colors.green),
                  child: Center(
                    child: Text(
                      'LEARN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                crossAxisEndOffset: 1,
                onDismissed: (direction) async {
                  Scaffold.of(context).hideCurrentSnackBar();
                  final snackBar = SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text(
                      direction == DismissDirection.startToEnd
                          ? 'You knew ${widget.data.word}'
                          : 'Added ${widget.data.word} to learn list',
                      style:
                          TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
                    ),
                    backgroundColor: Colors.deepOrange.withOpacity(0.65),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                  //TODO
                  // if (direction == DismissDirection.startToEnd) {
                  //   await Provider.of<ListCardItem>(context, listen: false)
                  //       .remove(widget.data.id);
                  // } else if (direction == DismissDirection.endToStart) {
                  //   await Provider.of(context, listen: false).add(widget.data);
                  // }
                },
                // confirmDismiss: (direction) {},
                movementDuration: duration2,
                background: Container(
                  child: Center(
                      child: const Text(
                    'KNEW',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  )),
                  decoration: BoxDecoration(color: Colors.purple),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 15, bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromRGBO(255, 255, 180, 1),
                        border: Border.all(
                          width: 0.5,
                          color: Colors.black38,
                        ),
                      ),
                      margin: const EdgeInsets.only(
                          left: 5, right: 5, bottom: 7, top: 7),
                      child: Column(
                        children: <Widget>[
                          cardWord,
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        meaningWord,
                        //
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isShowedExampleMeaning = !isShowedExampleMeaning;
                            });
                          },
                          child: exampleContainer,
                        ),
                        meaningContainer,
                      ],
                    ),
                  ],
                ),
                key: Key(
                  widget.data.id.toString(),
                ),
              );
      },
    );
  }
}
