import 'package:sqflite/sqflite.dart';

class DataBaseClient {
  static late Database database;
  static List<Map> allCharacters = [];

  static createDataBase() {
    openDatabase('marvelPreview.db', version: 1, onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE Characters (id INTEGER PRIMARY KEY, imagePath TEXT, characterName TEXT)')
          .then((value) => print('DataBase: table created'))
          .catchError((error) {
        print('DataBase: Error when creating table ${error.toString()}');
      });
    }, onOpen: (database) {})
        .then((value) {
      database = value;
    });
  }

  static insertInDataBase({
    required String imagePath,
    required String characterName,
  }) async {
    await database
        .rawInsert(
      'INSERT INTO Characters(imagePath, characterName) VALUES("$imagePath", "$characterName")',
    )
        .then((value) {
      print('$value DataBase: inserted successfully');
      getDataFromDatabase(database: database);
    }).catchError((error) {
      print('DataBase: Error When Inserting New Record ${error.toString()}');
    });
  }

  static getDataFromDatabase({database}) async {
    allCharacters = [];
    await database
        .rawQuery('SELECT * FROM Characters order By id')
        .then((value) {
      allCharacters = value;
    });
    print('DataBase: getting Data successfully');
  }

  static Future<void> deleteAll() async {
    database.rawDelete('DELETE FROM Characters').then((value) {
      print('DataBase: Delete all successfully');
    });
  }
}
