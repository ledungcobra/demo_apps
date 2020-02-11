import 'package:flutter/material.dart';
import '../models/card_item.dart';

class AddCardDialog extends StatefulWidget {
  const AddCardDialog({
    Key key,
  }) : super(key: key);

  @override
  _AddCardDialogState createState() => _AddCardDialogState();
}

class _AddCardDialogState extends State<AddCardDialog> {
  final _form = GlobalKey<FormState>();
  String word;
  String meaning;
  String example;
  String imageUrl;
  String group;

  var _listType = List.generate(4, (_) => false);
  String getType() {
    final index = _listType.indexWhere((test) => test);
    if (index < 0) {
      return null;
    }
    switch (index) {
      case 0:
        return 'noun';
      case 1:
        return 'adj';
      case 2:
        return 'adv';
      case 3:
        return 'verb';
    }
  }

  void _submitForm() {
    int index = _listType.indexWhere((test) => test);
    if (!_form.currentState.validate()) {
      return;
    }

    _form.currentState.save();
    print(index);
    print(word);
    print(example);
    if (index < 0 || word == null || meaning == null || example == null) {
      return;
    }

    final card = CardItem(
      word: word,
      example: example,
      type: getType(),
      meaning: meaning,
      topic: group,
      imageUrl: imageUrl,
    );
    //TODO
    //Provider.of<ListCardItem>(context, listen: false).add(card);
    print('go');

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      semanticLabel: 'Label',
      elevation: 30,
      contentPadding: EdgeInsets.all(30),
      backgroundColor: Color.fromRGBO(200, 255, 160, 0.85),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      children: <Widget>[
        Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Word'),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null) {
                    return 'You must type Word';
                  }
                },
                onSaved: (value) {
                  word = value;
                },
              ),
              SizedBox(
                height: 25,
              ),
              ToggleButtons(
                children: <Widget>[
                  Text('NOUN', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('ADJ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('ADV', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('VERB', style: TextStyle(fontWeight: FontWeight.bold))
                ],
                isSelected: _listType,
                onPressed: (index) {
                  int count = 0;
                  int pos = null;

                  for (int i = 0; i < _listType.length; i++) {
                    if (_listType[i] == true) {
                      count++;
                      pos = i;
                    }
                  }
                  if (count == 0 ||
                      (count == 1 && pos != null && pos == index)) {
                    _listType[index] = !_listType[index];
                    setState(() {});
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Group'),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null) {
                    return 'You must fill this field';
                  }
                },
                onSaved: (value) {
                  group = value;
                },
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Meaning'),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null) {
                    return 'You must complete meaning field';
                  }
                },
                onSaved: (value) {
                  meaning = value;
                },
              ),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Example'),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null) {
                    return 'You must enter example';
                  }
                },
                onSaved: (value) {
                  example = value;
                },
              ),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Image Url'),
                keyboardType: TextInputType.text,
                onSaved: (value) {
                  imageUrl = value;
                },
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      print('Submit');
                      _submitForm();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
