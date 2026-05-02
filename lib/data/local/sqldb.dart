import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initalDb();
      return _db;
    } else {
      return _db;
    }
  }

  initalDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(
      databasepath,
      'expense_app.db',
    ); // the name of the database
    Database mydb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onUpgrade: _onUpgrade,
    );
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) async {
    if (oldversion < 2) {
      await db.execute("ALTER TABLE 'expenses' ADD COLUMN 'description' TEXT");
    }
    print("onUpgrade =====================================");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE "expenses" (
    "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT, 
    "title" TEXT NOT NULL,
    "amount" REAL NOT NULL,
    "category" TEXT NOT NULL,
    "date" TEXT NOT NULL
  )
 ''');
    print(" onCreate =====================================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  mydeleteDatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'expense_app.db');
    await deleteDatabase(path);
  }
}
