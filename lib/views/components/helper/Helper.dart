import 'package:budget_tracker_app/models/budgetModel.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper extends GetxController{
  DbHelper._();

  static DbHelper dbHelper = DbHelper._();
static Database? db;
  Future initDb()async{
    String dbPath = await getDatabasesPath();
    String path = await join(dbPath,"budgetdb.db");
    print("=========================");
    print("88888");
    print("=========================");


     db= await openDatabase(path,version: 1,onCreate: (Database db, int version)async{
      await db.execute("CREATE TABLE budget(id INTEGER PRIMARY KEY AUTOINCREMENT,category_name TEXT,category_image TEXT)");
    },);
    print("=========================");
    print("dbjd");
    print("=========================");

  }
  Future<int?> addCategory({required BudgetModel model})async{
    await initDb();
    String query = "INSERT INTO budget(category_name,category_image) VALUES (?,?);";
    List arg = [model.category_name,model.category_image as String];
    int? res = await db?.rawInsert(query,arg);
    return res;
  }

  Future<List<BudgetModel>>? FetchAllCategory()async{
    await initDb();

    String query = "SELECT * FROM budget;";
    List<Map<String,dynamic>>? res = await db?.rawQuery(query);

    List<BudgetModel> alldata = res!.map((e) => BudgetModel.sql(data: e)).toList();
    return alldata;
  }

}