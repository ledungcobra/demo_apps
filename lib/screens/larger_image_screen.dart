import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LargerImageScreen extends StatelessWidget {
  // const LargerImageScreen({Key key}) : super(key: key);
  static const String routeName = '/Largerimage';
  var word;
  String imageUrl;
  Future<void> _getUrl(BuildContext ctx) async {
    word = ModalRoute.of(ctx).settings.arguments as String;
    String url =
        'https://pixabay.com/api/?key=15047067-8d10ac0e360ba06c755c43410&q=$word=photo';
    final response = await http.get(url);
    final data = json.decode(response.body) as Map<String, dynamic>;
    final listResult = data['hits'] as List<dynamic>;
    imageUrl = listResult.length > 0
        ? (listResult.first as Map<String, dynamic>)['largeImageURL']
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Larger'),
      ),
      body: Center(
        child: FutureBuilder(
          builder: (ctx, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? CircularProgressIndicator()
                : GestureDetector(
                    onVerticalDragEnd: (drag) {
                      Navigator.of(ctx).pop();
                    },
                    child: Container(
                      height: MediaQuery.of(ctx).size.height * 0.9,
                      width: MediaQuery.of(ctx).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Hero(
                          tag: word,
                          child: FadeInImage.assetNetwork(
                            image: imageUrl,
                            fit: BoxFit.contain,
                            placeholder: 'assets/placeholder.png',
                          ),
                        ),
                      ),
                    ),
                  );
          },
          future: _getUrl(context),
        ),
      ),
    );
  }
}
