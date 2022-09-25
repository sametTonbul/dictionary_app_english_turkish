import 'package:dictionary_app/databaseHelper.dart';
import 'package:dictionary_app/words.dart';

class WordsDatabaseAO {
  Future<List<Words>> allWords() async {
    var database = await DatabaseHelper.accessDatabase();

    List<Map<String, dynamic>> mapsWords =
        await database.rawQuery('SELECT * FROM Words');

    return List.generate(mapsWords.length, (index) {
      var rowMapsWords = mapsWords[index];

      return Words(rowMapsWords['word_id'], rowMapsWords['word_english'],
          rowMapsWords['word_turkish']);
    });
  }

  Future<List<Words>> searchWord(String searchingWord) async {
    var database = await DatabaseHelper.accessDatabase();

    List<Map<String, dynamic>> mapsWords = await database.rawQuery(
        "SELECT * FROM Words WHERE word_english like '%$searchingWord%' ");

    return List.generate(mapsWords.length, (index) {
      var rowMaps = mapsWords[index];

      return Words(
          rowMaps['word_id'], rowMaps['word_english'], rowMaps['word_turkish']);
    });
  }
}
