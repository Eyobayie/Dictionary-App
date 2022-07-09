import 'package:flutter/material.dart';
import 'package:geezamharic/all_constants/constants.dart';
import 'package:geezamharic/models/word.dart';
import 'package:geezamharic/providers/db_helper.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../screens/definition_screen.dart';

class WordItem extends StatelessWidget with ChangeNotifier {
  WordItem({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final word= Rxn<Word>();
    // final helper=Get.find<DBHelper>();
    final word = Provider.of<Word>(context);
    final helper = Provider.of<DBHelper>(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 1),
        color: Colors.white,
        shadowColor: Colors.white,
        elevation: 0,
        child: ListTile(
          title: Text(
            word.title,
            maxLines: 1,
            style: Constant.titleStyle,
          ),
          subtitle: Text(
            word.definition,
            maxLines: 1,
            style: Constant.definitionStyle,
          ),
          trailing: word.isFavorite == 1
              ? IconButton(
                  onPressed: () {
                    helper.toggleFavorite(word,word.id);
                  },
                  icon: const Icon(Icons.favorite),
                  color: Colors.red,
                )
              : IconButton(
                  onPressed: () async {
                    helper.toggleFavorite(word, word.id);
                  },
                  icon: const Icon(Icons.favorite_border),
                ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(DefinitionScreen.routeName, arguments: word);
          },
        ),
      ),
    );
  }
}
