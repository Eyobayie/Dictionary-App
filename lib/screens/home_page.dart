import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geezamharic/models/word.dart';
import 'package:geezamharic/providers/db_helper.dart';
import 'package:geezamharic/widgets/word_item.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // DBHelper dbHelper = DBHelper();
  // initialize() async {
  //   return await dbHelper.selectData2().then((_) => dbHelper.fetchFavorite());
  // }

  Color iconColor = Colors.black;
  bool onOff = false;
  late FloatingSearchBarController controller;
  late List<Word>? searchedList = [];
  DBHelper dbHelper = DBHelper();
  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    initialize();
  }
  void initialize() {
    searchedList = Provider.of<DBHelper>(context, listen: false)
        .filterSearchTerms(filter: '');
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wordLists = Provider.of<DBHelper>(context).getAllWordLists;
    TextEditingController textEditingController = TextEditingController();
    //final wordLists=Get.put(DBHelper().getAllWordLists);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('ግዕዝ መዝገበ ቃላት'),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
      ),
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height *0.01,
            horizontal:MediaQuery.of(context).size.width *0.02 ),
            child: SizedBox(
              height:MediaQuery.of(context).size.height *0.06,
              child: Consumer<DBHelper>(
                builder: ((context, dbhelper, child) =>TextField(
                  //controller: textEditingController,
                  onChanged: (value){
                  searchedList=dbhelper.filterSearchTerms(filter: value);
                  },
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.search),
                    suffixIconColor: Colors.purple,
                    hintText: 'ፈልግ...',
                    hintStyle:
                        const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold,color:Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.purple,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )),
              ),
            ),
          ),
         searchedList!.isEmpty? Expanded(
                  child: ListView.builder(
                    // padding: EdgeInsets.symmetric(
                    //     vertical: MediaQuery.of(context).size.height * 0.08),
                    itemCount: wordLists.length,
                    itemBuilder: ((context, index) =>
                        ChangeNotifierProvider.value(
                          value: wordLists[index],
                          child: WordItem(),
                        )),
                  ),
                ):Expanded(
                  child: ListView.builder(
                    // padding: EdgeInsets.symmetric(
                    //     vertical: MediaQuery.of(context).size.height * 0.08),
                    itemCount: searchedList!.length,
                    itemBuilder: ((context, index) =>
                        ChangeNotifierProvider.value(
                          value: searchedList![index],
                          child: WordItem(),
                        )),
                  ),
              ),
          ],
      ), //FloatingSearchBar(
      //     controller: controller,
      //     clearQueryOnClose: true,
      //     actions: [
      //       FloatingSearchBarAction.searchToClear(),
      //     ],
      //     onQueryChanged: (query) {
      //       searchedList = Provider.of<DBHelper>(context)
      //           .filterSearchTerms(filter: query);
      //     },
      //     onSubmitted: (_){
      //       controller.close();
      //     },
      //     //transition: FloatingSearchBarTransition(),
      //     height: MediaQuery.of(context).size.height * 0.06,
      //     borderRadius: const BorderRadius.all(Radius.circular(20)),
      //     elevation: 0,
      //     hint: 'ፈልግ...',
      //     border: const BorderSide(color: Colors.purple, width: 3),
      //     builder: (context, alawk) =>Container(),
      //     iconColor: Colors.purple,
      //    body:

      //),
    );
  }
}
