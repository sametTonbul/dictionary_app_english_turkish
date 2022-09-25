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
  String searchWord = '';

  Future<List<Words>> showAllWords() async {
    var wordsList = <Words>[];

    var word1 = Words(1, 'door', 'kapı');
    var word2 = Words(1, 'doors', 'kapıasd');
    var word3 = Words(1, 'doorda', 'kapasdı');

    wordsList.add(word1);
    wordsList.add(word2);
    wordsList.add(word3);

    return wordsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          isSearchDo
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isSearchDo = false;
                      searchWord = '';
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
        centerTitle: true,
        title: isSearchDo
            ? TextField(
                decoration: InputDecoration(hintText: 'Search here'),
                onChanged: (resultSearch) {
                  print('resultSearch : $resultSearch');
                  setState(() {
                    searchWord = resultSearch;
                  });
                },
              )
            : Text('Dictionary App'),
      ),
      body: FutureBuilder<List<Words>>(
        future: showAllWords(),
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
                          builder: (context) => DetailPage(word:word),
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
