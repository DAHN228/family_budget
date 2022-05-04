import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:family_budget/models/budget-entry.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'budgetentries.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE budgetentries(
      id INTEGER PRIMARY KEY,
      userName TEXT,
      cost REAL,
      transactionType TEXT,
      transactionCategory TEXT
    )
    ''');
  }
  Future<List<BudgetEntry>> getBudgetEntries() async {
    Database db = await instance.database;
    var budgetEntries = await db.query('budgetentries', orderBy: 'userName');
    List<BudgetEntry> budgetEntriesList = budgetEntries.isNotEmpty
        ? budgetEntries.map((c) => BudgetEntry.fromMap(c)).toList()
        : [];
    return budgetEntriesList;
  }
  Future<List<BudgetEntry>> getIncomeEntries() async {
    Database db = await instance.database;
    var budgetEntries = await db.rawQuery("SELECT * FROM budgetentries where transactionType = 'Получено'");
    List<BudgetEntry> budgetEntriesList = budgetEntries.isNotEmpty
        ? budgetEntries.map((c) => BudgetEntry.fromMap(c)).toList()
        : [];
    return budgetEntriesList;
  }
  Future<List<BudgetEntry>> getExpensesEntries() async {
    Database db = await instance.database;
    var budgetEntries = await db.rawQuery("SELECT * FROM budgetentries where transactionType = 'Потрачено'");
    List<BudgetEntry> budgetEntriesList = budgetEntries.isNotEmpty
        ? budgetEntries.map((c) => BudgetEntry.fromMap(c)).toList()
        : [];
    return budgetEntriesList;
  }
  Future <int> add(BudgetEntry entry) async {
    Database db = await instance.database;
    return await db.insert('budgetentries', entry.toMap() );
  }
  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('budgetentries', where: 'id = ?', whereArgs: [id]);
  }
  Future<int> update(BudgetEntry entry) async {
    Database db = await instance.database;
    return db.update('budgetentries', entry.toMap(), where: 'id = ?', whereArgs: [entry.id]);
  }
}