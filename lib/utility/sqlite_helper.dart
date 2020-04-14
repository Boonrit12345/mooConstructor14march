import 'package:mooconstructor14march/models/template_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteHelper {
  // Field
  String nameDatabase = 'tamplateFile.db';

  // Method
  SqliteHelper() {
    initDataBase();
  }



  Future<void> initDataBase() async {
    String sqlTABLE =
        'CREATE TABLE tamplateTABLE (id INTEGER PRIMARY KEY, CarName TEXT, CarColor TEXT)';

    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (Database database, int version) {
      return database.execute(sqlTABLE);
    }, version: 1);
  }



// createDatabase
  Future<void> insertValueToSQLite(TemplateModel model) async {
    Database database =
        await openDatabase(join(await getDatabasesPath(), nameDatabase));

    try {
      database.insert(
        'tamplateTABLE',
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Insert Success');
    } catch (e) {
      print('Insert Errorr ===>>> ${e.toString()}');
    }
  }
}
