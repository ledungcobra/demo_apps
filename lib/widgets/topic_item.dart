import 'package:demo_apps/screens/topic_screen.dart';
import 'package:flutter/material.dart';

class TopicItem extends StatelessWidget {
  //const TopicItem({Key key}) : super(key: key);
  final String content;
  final int index;
  TopicItem(this.content, this.index);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
    
        Navigator.of(context)
            .pushNamed(TopicScreen.routeName, arguments: content);
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 202, 200, 1),
          borderRadius: index % 2 == 1
              ? const BorderRadius.only(topRight: Radius.circular(20))
              : const BorderRadius.only(topLeft: Radius.circular(20)),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      if (index % 2 == 0)
                        const SizedBox(
                          width: 10,
                        ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 230, 200, 1),
                            borderRadius: index % 2 == 1
                                ? BorderRadius.only(
                                    topRight: const Radius.circular(55),
                                  )
                                : BorderRadius.only(
                                    topLeft:const  Radius.circular(55),
                                  ),
                          ),
                          child: Center(
                            child: Text(
                              content,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ),
                      if (index % 2 == 1)
                        SizedBox(
                          width: 15,
                        )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
