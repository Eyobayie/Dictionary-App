import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:geezamharic/models/word.dart';

class DBHelper with ChangeNotifier {
  Database? database;
  static List<Word> _allWordList = [];
  static List<Word> favoriteList = [];
  final List<Word> _searchHistory = [];
  Future<void> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, "geez.db");
    bool dbExists = await File(dbPath).exists();
    if (!dbExists) {
      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "geez.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      // Write and flush the bytes written
      await File(dbPath).writeAsBytes(bytes, flush: true);
      print("ዳታቤዝ ኤግዚስት ? ትሩ");
    }
    database = await openDatabase(dbPath);
    print(database!.isOpen);
    print("initDB ኮልድ? ትሩ");
    notifyListeners();
  }

  Future<void> selectData2() async {
    if (database == null) {
      await initDB();
    }
    var res = await database!.query("wordTable");
    _allWordList = res.map((e) => Word.fromJson(e)).toList();
    print(getAllWordLists.length.toString());
    notifyListeners();
  }

  List<Word> get allFavorites {
    return [...favoriteList];
  }

  List<Word> get getAllWordLists {
    return [..._allWordList];
  }

  void fetchFavorite() {
    favoriteList =
        _allWordList.where((element) => element.isFavorite == 1).toList();
    print('favorite list length is ' + favoriteList.length.toString());
    notifyListeners();
  }

  void toggleFavorite(Word word, int id) async {
    if (database == null) {
      await initDB();
    }
    print('first isFavorite value is ' + word.isFavorite.toString());
    word.isFavorite == 1
        ? await database!
            .rawUpdate('UPDATE wordTable SET isFavorite=0 WHERE id=$id')
            .then((_) => word.isFavorite = 0)
            .then((_) => removeFromFavorite(word))
        : await database!
            .rawUpdate('UPDATE wordTable SET isFavorite=1 WHERE id=$id')
            .then((_) => word.isFavorite = 1)
            .then((_) => addToFavorite(word));
    notifyListeners();
  }
  
  void removeFromFavorite(Word word) {
    favoriteList.remove(word);
  }

  void addToFavorite(Word word) {
    favoriteList.insert(0, word);
  }

  List<Word> get getFilteredSearchTerms {
    return [..._searchHistory];
  }
  List<Word> filterSearchTerms({required String filter}) {
    if (filter != null && filter.isNotEmpty) {
      notifyListeners();
      return getAllWordLists
          .where((term) => term.title.startsWith(filter))
          .toList();
    } else {
      return _searchHistory;
    }
  }
}
