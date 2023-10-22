import 'dart:convert';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper instance = DBHelper.internal();

  factory DBHelper() => instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
      return _db!;
    } else {
      return _db!;
    }
  }

  DBHelper.internal();

  Future<Database> initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = "${documentsDirectory.path}/imltest.db";
    Database theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE if NOT EXISTS tblCountry(id INTEGER PRIMARY KEY,json_data TEXT)");
  }

  Future<int> insertVillage(Map<String, dynamic> countryDetails) async {
    var dbClient = await db;
    int res = 0;
    res = await dbClient
        .insert("tblCountry", {"json_data": json.encode(countryDetails)});
    return res;
  }

  Future<List<Map<String, dynamic>>> getLocalCountryList() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM tblCountry');
    List<Map<String, dynamic>> villageList = [];
    for (int i = 0; i < list.length; i++) {
      villageList.add(jsonDecode(list[i]["json_data"]));
    }
    return villageList;
  }

  Future<int> clearCountryList() async {
    var dbClient = await db;
    int rows = await dbClient.delete("tblCountry");
    return rows;
  }
}