import 'package:demo_apps/models/card_item.dart';
import 'package:demo_apps/providers/list_card_item.dart';
import 'package:demo_apps/widgets/add_item_dialog.dart';
import 'package:demo_apps/widgets/demo_item.dart';
import 'package:demo_apps/widgets/topic_item.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  //const HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _selectedIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero).then((_) async {
      final pref = await SharedPreferences.getInstance();

      bool isFirstLoad = true;

      isFirstLoad = pref.getBool("isFirstLoad");
      // if (isFirstLoad == null) {
      //   pref.setBool("isFirstLoad", false);
      //   isFirstLoad = true;
      // }
      final listCard = Provider.of<ListCardItem>(context, listen: false);
      // //Write Data
      //await listCard.db.deleteFile();

      // listCard.map.forEach((topic, listItem) {
      //   for (int i = 0; i < listItem.length; i++) {
      //     listItem[i].topic = topic;
      //     listCard.db.saveCard(listItem[i]);
      //   }
      // });
      //Fetch data

    //  await listCard.fetchAllData();
    //await listCard.fetchSpecificTypeOfCard(TypeOfCard.Init);
    
      // if (isFirstLoad == true) {
      //   //Write data to app

      // } else {
      //   //Fetch all data
      //   Provider.of<ListCardItem>(context, listen: false).fetchAllData();
      //   print("call");

      // }

      //await dbHelper.deleteFile();
      // await Provider.of<ListCardItem>(context,listen: false).writeData();
      //  await Provider.of<ListCardItem>(context, listen: false).fetchData();
      // await Provider.of<LearnListItem>(context, listen: false).fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var appBar2 = AppBar(
      title: const Text('Home'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AddCardDialog(),
            );
          },
        )
      ],
    );
  
    var sliverGrid = SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      delegate: SliverChildBuilderDelegate((ctx, index) {
        return TopicItem(Provider.of<ListCardItem>(ctx).topic[index], index);
      }, childCount: Provider.of<ListCardItem>(context).topic.length),
    );
   
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Choose your topic",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              background: Image.asset(
                "assets/placeholder.png",
                fit: BoxFit.fitWidth,
              ),
            ),
            
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AddCardDialog(),
                  );
                },
              ),
            ],
          ),
          SliverList(
              delegate: SliverChildListDelegate(
                [
            SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.3,
              //Demo
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Provider.of<ListCardItem>(context).items.length,
                  itemBuilder: (ctx,i)=>DemoItem(Provider.of<ListCardItem>(context).items[i]),               
                  
                ),
              ),
            )
          ])),
          sliverGrid
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _selectPage,
        unselectedItemColor: Colors.blue,
        backgroundColor: Colors.white60,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            title: Text('Category'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_off),
            title: Text('Learn'),
          )
        ],
      ),
    );
  }
}




