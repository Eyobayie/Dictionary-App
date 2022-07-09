import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
class Word with ChangeNotifier {
  late int id;
  late String title;
  late String definition;
  late int isFavorite;
  Word({
    required this.id,
    required this.title,
    required this.definition,
    required this.isFavorite,
});
factory Word.fromJson(Map<String, dynamic> wordJson){
return Word(
 id: wordJson['id'],
 title:wordJson['geez'],
 definition: wordJson['amharic'],
 isFavorite: wordJson['isFavorite']); 
   }
}