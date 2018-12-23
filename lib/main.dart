import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';  // Add this line.

void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      //final wordPair = new WordPair.random(); // Add this line.
    return new MaterialApp(
      color: Colors.red,
      title: 'Startup Name Generator',
      theme: new ThemeData(          // Add the 3 lines from here... 
        primaryColor: Colors.white,
      ),
      home: new RandomWords(),
    );
  }
}

//********************************RandomWordsState******************************************************* */

//the class that will show the words
class RandomWordsState extends State<RandomWords> {

    //WordPair is a predefined class in the package of engish words
    final List<WordPair> _suggestions = <WordPair>[];

    //This Set stores the word pairings that the user favorited. 
    //Set is preferred to List because a properly implemented Set does not allow 
    //duplicate entries
    final Set<WordPair> _saved = new Set<WordPair>();
    final TextStyle _biggerFont = const TextStyle(fontSize: 18.0,color: Colors.black); 

   Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      // The itemBuilder callback is called once per suggested 
      // word pairing, and places each suggestion into a ListTile
      // row. For even rows, the function adds a ListTile row for
      // the word pairing. For odd rows, the function adds a 
      // Divider widget to visually separate the entries. Note that
      // the divider may be difficult to see on smaller devices.
      itemBuilder: (BuildContext _context, int i) {
        // Add a one-pixel-high divider widget before each row 
        // in the ListView.
        if (i.isOdd) {
          return new Divider();
        }

        // The syntax "i ~/ 2" divides i by 2 and returns an 
        // integer result.
        // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
        // This calculates the actual number of word pairings 
        // in the ListView,minus the divider widgets.
        final int index = i ~/ 2;
        // If you've reached the end of the available word
        // pairings...
        if (index >= _suggestions.length) {
          // ...then generate 10 more and add them to the 
          // suggestions list.
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );
  }

    Widget _buildRow(WordPair pair) {
      //In the _buildRow function, add an alreadySaved check to ensure that a word 
      //pairing has not already been added to favorites.
      final bool alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      //In _buildRow() you'll also add heart-shaped icons to the ListTile objects 
      //to enable favoriting. In the next step, you'll add the ability to interact
      // with the heart icons.
      trailing: new Icon(   // Add the lines from here... 
      alreadySaved ? Icons.favorite : Icons.favorite_border,
      color: alreadySaved ? Colors.red : null,
    ),  
    onTap: () {       
      setState(() {
        if (alreadySaved) {
          _saved.remove(pair);
        } else { 
          _saved.add(pair); 
        } 
      });
    },
    );
  }

  void _pushSaved() {
  Navigator.of(context).push(
    new MaterialPageRoute<void>(   // Add 20 lines from here...
      builder: (BuildContext context) {
        final Iterable<ListTile> tiles = _saved.map(
          (WordPair pair) {
            return new ListTile(
              title: new Text(
                pair.asPascalCase,
                style: _biggerFont,
              ),
            );
          },
        );
        final List<Widget> divided = ListTile
          .divideTiles(
            context: context,
            tiles: tiles,
          )
          .toList();
          return new Scaffold(         // Add 6 lines from here...
          appBar: new AppBar(
            title: const Text('Saved Suggestions'),
            backgroundColor: Colors.orangeAccent,
          ),
          body: new ListView(children: divided),
        ); 
      },
    ),                           // ... to here.
  );
}

  @override                                   
  Widget build(BuildContext context) {
    //final WordPair wordPair = new WordPair.random();
    //return new Text(wordPair.asPascalCase);
     return new Scaffold (                   // Add from here... 
      appBar: new AppBar(
        backgroundColor: Colors.orangeAccent,
        title: new Text('Startup Name Generator'),
         actions: <Widget>[      // Add 3 lines from here...
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ], 
      ),
      body: _buildSuggestions(),
    ); 
  }                                          
   
}

// class to creat the object (state) that will show the words
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}