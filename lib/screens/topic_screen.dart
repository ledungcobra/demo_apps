import 'package:demo_apps/providers/list_card_item.dart';
import 'package:demo_apps/widgets/scroll_list_card.dart';
import 'package:demo_apps/widgets/stack_list_card_item.dart';
import 'package:flutter/material.dart';
import '../models/card_item.dart';

import 'package:provider/provider.dart';

class TopicScreen extends StatefulWidget {
  static const String routeName = '/topicScreen';

  @override
  _TopicScreenState createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  int mode = 1;

  @override
  Widget build(BuildContext context) {
    final topic = ModalRoute.of(context).settings.arguments as String;
    final listItem = Provider.of<ListCardItem>(context).listAtKey(topic,TypeOfCard.Init);
    return Scaffold(
      appBar: AppBar(
        title: Text(topic),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              mode == 1 ? Icons.label_outline : Icons.label_important,
            ),
            onPressed: () {
              setState(() {
                if (mode == 1) {
                  mode = 2;
                } else {
                  mode = 1;
                }
              });
            },
          )
        ],
      ),
      body: mode !=1 ?ScrollListCardItem(listItem):StackListCardItem(listItem,ModeLearn.Overview),
      
    );
  }
}
