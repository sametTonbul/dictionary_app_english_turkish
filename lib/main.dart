import 'package:dictionary_app/databaseAO.dart';
import 'package:dictionary_app/detailPage.dart';
import 'package:dictionary_app/words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isSearchDo = false;
  String searchingWord = '';

  Future<List<Words>> showAllWords() async {
    var wordsList = await WordsDatabaseAO().allWords();
    return wordsList;
  }

  Future<List<Words>> searchWord(String searchingWord) async {
    var wordsList = await WordsDatabaseAO().searchWord(searchingWord);
    return wordsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearchDo ?
         TextField(
                decoration: InputDecoration(hintText: 'Search here'),
                onChanged: (resultSearch) {
                  print('resultSearch : $resultSearch');
                  setState(() {
                    searchingWord = resultSearch;
                  });
                },
              )
            : Text('Dictionary App'),
        actions: [
          isSearchDo
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isSearchDo = false;
                      searchingWord = '';
                    });
                  },
                  icon: Icon(Icons.cancel))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isSearchDo = true;
                    });
                  },
                  icon: Icon(Icons.search))
        ],
      ),
      body: FutureBuilder<List<Words>>(
        future: isSearchDo ? searchWord(searchingWord) : showAllWords(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var wordList = snapshot.data;
            return ListView.builder(
              itemCount: wordList!.length,
              itemBuilder: (context, index) {
                var word = wordList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(word),
                        ));
                  },
                  child: SizedBox(
                    height: 50,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(word.word_english),
                          Text(
                            word.word_turkish,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
