import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';  // Add this line.

void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      final wordPair = new WordPair.random(); // Add this line.
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: new Center(   
          child: new Text(wordPair.asCamelCase), 
        ),
      ),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  @override                                   
  Widget build(BuildContext context) {
    final WordPair wordPair = new WordPair.random();
    return new Text(wordPair.asPascalCase);
  }                                          
   
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}