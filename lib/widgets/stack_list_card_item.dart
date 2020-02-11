import 'package:demo_apps/models/card_item.dart';
import 'package:demo_apps/providers/list_card_item.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:provider/provider.dart';

enum ModeLearn { Overview, Learn }

class StackListCardItem extends StatefulWidget {
  final List<CardItem> listCard;
  final mode;
  Key key;

  StackListCardItem(this.listCard, this.mode, {this.key});
  int index = 0;

  @override
  _StackListCardItemState createState() => _StackListCardItemState();
}

class _StackListCardItemState extends State<StackListCardItem>
    with SingleTickerProviderStateMixin {
  final cardColor = Color.fromRGBO(255, 255, 189, 1);

  var dragStarted = false;
  var wasClicked = false;
  @override
  void didUpdateWidget(StackListCardItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    this.widget.index = oldWidget.index;
  }

  Animation<double> animation;
  AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: pi)
        .animate(CurvedAnimation(parent: controller, curve: Curves.decelerate))
          ..addListener(() {
            setState(() {});
          });
    //  controller.forward();
    //controller.reverse();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Rebuild");
    // widget.listCard.forEach((item) {
    //   print(item.toMap().toString() + "\n");
    // });
    // print('------------------------');

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              draggableWidget("KNEW", 100,),
              Expanded(
                child: Container(),
              ),
              draggableWidget("LEARN", 100,)
            ]),
            Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.9,
              child: _3CardInStack(context),
            ),
          ],
        ),
      ),
    );
  }

  Stack _3CardInStack(BuildContext context) {
    return Stack(children: [
      SizedBox(height: 50),
      Positioned(
        child: buildCardWithDegree(5),
        top: 30,
        left: 65,
      ),
      Positioned(
        child: buildCardWithDegree(15, () {
          String content = null;

          if (widget.index + 1 <= widget.listCard.length - 1) {
            content = widget.listCard[widget.index + 1].word;
          }
          return content;
        }()),
        top: 30,
        left: 65,
      ),
      Positioned(
        child: Transform(
          origin: Offset(0, MediaQuery.of(context).size.height * 0.4),
          transform: Matrix4.identity()..rotateX(animation.value),

          // angle: pi / 3,
          child: Draggable<String>(
            data: widget.listCard[widget.index].word,
            onDragStarted: () {
              setState(() {
                dragStarted = true;
              });
            },
            onDraggableCanceled: (vel, off) {
              setState(() {
                dragStarted = false;
              });
            },
            child: !dragStarted
                ? GestureDetector(
                    onTap: () {
                      if (!wasClicked) {
                        controller.forward();
                      } else {
                        controller.reverse();
                      }

                      setState(() {
                        wasClicked = !wasClicked;
                      });
                    },
                    child: foreCard(context),
                  )
                : Center(child: Container()),
            feedback: smallerCurrentCard(context),
          ),
        ),
        top: 30,
        left: 65,
      ),
    ]);
  }

  Material smallerCurrentCard(BuildContext context) {
    return Material(
      color: Color.fromRGBO(220, 220, 220, 0.5),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Text(
            widget.listCard[widget.index].word,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }

  Container foreCard(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
          color: cardColor,
          border: Border.all(width: 1, color: Colors.grey.withOpacity(1)),
          borderRadius: BorderRadius.circular(15)),
      child: Stack(children: [
        Center(
          child: !wasClicked
              ? Text(
                  widget.listCard[widget.index].word,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 50),
                )
              : behindCard(context),
        ),
        Positioned(
          bottom: 0,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
            ),
            height: 30,
          ),
        )
      ]),
    );
  }

  Widget behindCard(BuildContext context) {
    return Transform.rotate(
      angle: pi,
      child: Transform(
        origin: Offset(MediaQuery.of(context).size.width * 0.35, 0),
        transform: Matrix4.identity()..rotateY(pi),
        child: Padding(
          padding: EdgeInsets.only(left: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            textDirection: TextDirection.ltr,
            children: <Widget>[
              Text(
                'Word: ' + widget.listCard[widget.index].word,
                style: TextStyle(fontSize: 35),
              ),

              Text(
                '( ' + widget.listCard[widget.index].type + ' )',
                style: TextStyle(fontSize: 35),
              ),

              Text(
                'Meaning: ' + widget.listCard[widget.index].meaning,
                style: TextStyle(fontSize: 35),
              ),

              Text(
                'Example: ' + widget.listCard[widget.index].example,
                style: TextStyle(fontSize: 25),
              ),

              if (widget.listCard[widget.index].synonym != null)
                Text(
                  "Synonym: " + widget.listCard[widget.index].synonym,
                  style: TextStyle(fontSize: 35),
                ),
              //Text('Synonym: ' + card.synonym!=null?card.synonym:"  "),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget draggableWidget(String acceptValue, [double width,Color color]) {
    return DragTarget<String>(
      key: Key(DateTime.now().toString()),
      onWillAccept: (value) {
        return true;
      },
      onAccept: (value) {
        final card = widget.listCard[widget.index];
        if (acceptValue == "LEARN") {
          Provider.of<ListCardItem>(context, listen: false).addToLearn(card);
        } else if (acceptValue == "KNEW") {
          Provider.of<ListCardItem>(context, listen: false).addToKnew(card);
        }

        setState(() {
          if (widget.index + 1 <= widget.listCard.length - 1) {
            widget.index++;
            dragStarted = false;
            if (controller.status == AnimationStatus.completed) {
              controller.reverse();
              wasClicked = false;
              print('Completed');
            }
          }
        });
      },
      builder: (ctx, listAcceptedValue, listRejectedValue) {
        print(listAcceptedValue);

        return Container(
          height: MediaQuery.of(context).size.height,
          width: width == null ? 40 : width,
          color: color!=null? color: null,
         
        );
      },
    );
  }

  RotationTransition buildCardWithDegree(double degree, [String content]) {
    return RotationTransition(
      turns: AlwaysStoppedAnimation(degree / 360),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
            color: cardColor,
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(15)),
        alignment: Alignment.center,
        child: content != null
            ? Text(content, style: TextStyle(fontSize: 35))
            : Container(),
      ),
    );
  }
}
