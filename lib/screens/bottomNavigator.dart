import 'package:flutter/material.dart';
import 'package:geezamharic/screens/definition_screen.dart';
import 'package:geezamharic/screens/home_page.dart';
import '../providers/db_helper.dart';
import 'favorite_screen.dart';
class BottomNavigator extends StatefulWidget {
 BottomNavigator({ Key? key }) : super(key: key);
  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
     DBHelper dbHelper = DBHelper();
  initialize() async {
    return await dbHelper.selectData2()
    .then((_) => dbHelper.fetchFavorite());
  }
  final popup=PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    child: Text("Change theme"),
                    value: 1,
                  ),
                  const PopupMenuItem(
                    child: Text("Rate us"),
                    value: 2,
                  ),
                  const PopupMenuItem(
                    child: Text("About us"),
                    value: 2,
                  ),
                ]
            );
 late List widgetList=[const HomePage(),const FavoriteScreen(),popup];
 int index=0;
 @override
 void initState() {
 super.initState();
 initialize();
  widgetList;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widgetList[index],
        bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.purple,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: index,
        elevation: 5,
        iconSize: 30,
        onTap: (slectedIndex){
          setState(() {
            index=slectedIndex;
          });
        },
        items:const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label:'home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label:'Favorites',
        ),
           BottomNavigationBarItem(
           icon: Icon(Icons.more_vert),
           label:'Favorites',
        ),     
       ],),
    );
  }
}