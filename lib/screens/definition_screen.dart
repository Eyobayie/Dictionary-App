import 'package:flutter/material.dart';
import 'package:geezamharic/all_constants/constants.dart';
import 'package:geezamharic/models/word.dart';

class DefinitionScreen extends StatelessWidget {
  const DefinitionScreen({Key? key}) : super(key: key);
  static const String routeName = 'definitionRoute';
  @override
  Widget build(BuildContext context) {
    final word = ModalRoute.of(context)!.settings.arguments as Word;
    return Scaffold(
      appBar: AppBar(
        title: const Text('ትርጉም'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
            word.title,
            style: Constant.titleStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              word.definition,
              style: Constant.definitionStyle,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
