import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

// App Main Entry Point
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: const HomeScreen(), // Pantalla de inicio con botones "Words" y "Nouns"
    );
  }
}

// Pantalla con dos botones para elegir entre "Words" y "Nouns"
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose an Option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RandomWordsScreen(), // Pantalla de palabras
                  ),
                );
              },
              child: const Text('Words'),
            ), SizedBox(
                height: 20,
              ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NounsScreen(), // Pantalla de sustantivos
                  ),
                );
              },
              child: const Text('Nouns'),
            ),
          ],
        ),
      ),
    );
  }
}

// Pantalla para mostrar una lista de pares de palabras
class RandomWordsScreen extends StatefulWidget {
  const RandomWordsScreen({super.key});

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWordsScreen> {
  final List<WordPair> _suggestions = [];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Words'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }

          return ListTile(
            title: Text(
              _suggestions[index].asPascalCase,
              style: _biggerFont,
            ),
          );
        },
      ),
    );
  }
}

// Pantalla para mostrar una lista de sustantivos
class NounsScreen extends StatefulWidget {
  const NounsScreen({super.key});

  @override
  _NounsState createState() => _NounsState();
}

class _NounsState extends State<NounsScreen> {
  final List<WordPair> _nouns = [];

  @override
  void initState() {
    super.initState();
    _nouns.addAll(generateWordPairs().take(10).map((wp) => WordPair(wp.first, 'Noun')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouns'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;
          if (index >= _nouns.length) {
            _nouns.addAll(generateWordPairs().take(10).map((wp) => WordPair(wp.first, 'Noun')));
          }

          return ListTile(
            title: Text(
              _nouns[index].asPascalCase,
            ),
          );
        },
      ),
    );
  }
}
