import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper extends GetxController{
  DbHelper._();

  static DbHelper dbHelper = DbHelper._();
static Database? db;
  void initDb()async{
    String dbPath = await getDatabasesPath();
    String path = await join(dbPath,"budgetdb.db");
    print("=========================");
    print("88888");
    print("=========================");


     db= await openDatabase(path,version: 1,onCreate: (Database db, int version)async{
      await db.execute("CREATE TABLE budget(id INTEGER,category_name TEXT,category_image TEXT)");
    },);
    print("=========================");
    print("dbjd");
    print("=========================");

  }


}