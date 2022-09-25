import 'package:flutter/material.dart';
import 'package:dictionary_app/words.dart';

class DetailPage extends StatefulWidget {
  Words word;
  DetailPage(this.word);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Detail Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(widget.word.word_english,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.pink)),
            Text(widget.word.word_turkish, style: TextStyle(fontSize: 40)),
          ],
        ),
      ),
    );
    ;
  }
}
