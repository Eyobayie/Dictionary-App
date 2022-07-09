import 'package:flutter/material.dart';
import 'package:geezamharic/providers/db_helper.dart';
import 'package:provider/provider.dart';

import '../widgets/word_item.dart';
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({ Key? key }) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
  DBHelper dbHelper=Provider.of<DBHelper>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('ተወዳጆች'),centerTitle: true,),
      body: ListView.builder(
        itemCount: dbHelper.allFavorites.length,
        itemBuilder: (context, index) =>ChangeNotifierProvider.value(
          value:dbHelper.allFavorites[index],
        child:  WordItem(),
      )),
    );
  }
}
