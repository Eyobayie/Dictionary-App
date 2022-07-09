import 'package:flutter/material.dart';
import 'package:geezamharic/models/word.dart';
import 'package:geezamharic/providers/db_helper.dart';
import 'package:geezamharic/screens/bottomNavigator.dart';
import 'package:geezamharic/screens/definition_screen.dart';
import 'package:geezamharic/screens/home_page.dart';
import 'package:geezamharic/widgets/word_item.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DBHelper(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home:  BottomNavigator(),
        routes: {
          DefinitionScreen.routeName:((context) => const DefinitionScreen()),
        },
      ),
    );
  }
}


