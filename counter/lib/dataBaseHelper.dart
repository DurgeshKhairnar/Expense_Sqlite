import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper{

  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();


  Future<Database> get database async {
     if(_database != null ) return _database!;

     _database = await _initDB('product.db');
     return _database!;
  }


  Future<Database> _initDB(String fileName) async{
      final dbPath = await getDatabasesPath();
      final path = join(dbPath,fileName);

      return await openDatabase(
        path,
        version:1,
        onCreate: _createDB,
      );
  }

  Future<void> _createDB(Database db , int version) async{
      await db.execute('''
        CREATE TABLE expenses (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL ,
          amount TEXT NOT NULL ,
          expense_date TEXT NOT NULL
         )
    ''');
  }

  Future<int> addExpense(Map<String,dynamic> expenses) async{
    final db = await database;
    return await db.insert('expenses',expenses);
  } 

  Future<List<Map<String,dynamic>>> getAllExpense() async{
    final db = await database;

    return db.query('expenses',orderBy:'expense_date DESC ,id DESC');
  }

  Future<double> getTotalExpenses() async{
    final db = await database;
    final result = await db.rawQuery(
      'SELECT SUM(amount) as total FROM expenses'
    );

    return (result.first['total'] as num?)?.toDouble() ?? 0.0;
  }

  Future<double> getTodayExpenses() async {
    final db = await database;

  final today = DateTime.now().toIso8601String().substring(0,10);

    final result = await db.rawQuery('''
        SELECT SUM(amount) as total FROM expenses
        WHERE expense_date = ?
    ''',[today]);

    return (result.first['total'] as num?)?.toDouble() ?? 0.0;
  }
}