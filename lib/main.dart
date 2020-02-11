import 'package:demo_apps/providers/list_card_item.dart';
import 'package:demo_apps/screens/home_screen.dart';
import 'package:demo_apps/screens/larger_image_screen.dart';
import 'package:demo_apps/screens/topic_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ListCardItem(),
        ),
      ],
      child: MaterialApp(
        
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.amber,
          textTheme: TextTheme(
            body1: TextStyle(color: Colors.black, fontSize: 20),
            body2: TextStyle(color: Colors.black, fontSize: 20),
            title: TextStyle(color: Colors.deepPurple, fontSize: 25),
          ),
        ),
        home: HomeScreen(),
        routes: {
          LargerImageScreen.routeName: (ctx) => LargerImageScreen(),
          TopicScreen.routeName: (ctx) => TopicScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
