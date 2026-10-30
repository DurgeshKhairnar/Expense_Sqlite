import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('product.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);
  
    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {

    await db.execute('''
    CREATE TABLE users (
      userId INTEGER PRIMARY KEY AUTOINCREMENT,
      userName TEXT NOT NULL UNIQUE,
      password TEXT NOT NULL
    )
  ''');

  await db.execute('''
    CREATE TABLE account (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL, 
      balance REAL NOT NULL,
      iconCode INTEGER NOT NULL,
      userId INTEGER NOT NULL,
      FOREIGN KEY (userId) REFERENCES users(userId)
    )
  ''');

  await db.execute('''
    CREATE TABLE categories (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      iconCode INTEGER NOT NULL,
      color INTEGER NOT NULL,
      type TEXT NOT NULL,
      expense REAL NOT NULL,
      userId INTEGER NOT NULL,
      FOREIGN KEY (userId) REFERENCES users(userId)
    )
  ''');

  await db.execute('''
    CREATE TABLE expenses (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      amount REAL NOT NULL,
      date TEXT NOT NULL,
      iconCode INTEGER NOT NULL,
      accountId INTEGER,
      categoryId INTEGER,
      userId INTEGER NOT NULL,
      FOREIGN KEY (userId) REFERENCES users(userId),
      FOREIGN KEY (accountId) REFERENCES account(id),
      FOREIGN KEY (categoryId) REFERENCES categories(id)
    )
  ''');


    //  await insertDB(db);
    // await insertCategories(db);
  }

  Future<int> insertUser(String userName, String password) async {
  final db = await database; 
  
  return await db.insert(
    'users', 
    {
      'userName': userName, 
      'password': password,
    },
  );
}

Future<Map<String, dynamic>?> checkLogin(String userName, String password) async {
  final db = await database;

  final List<Map<String, dynamic>> results = await db.query(
    'users',
    where: 'userName = ? AND password = ?',
    whereArgs: [userName, password],
  );

  if (results.isNotEmpty) {
    return results.first;
  }

  return null;
}

Future<int> updateUserPassword({
  required String userName,
  required String newPassword,
}) async {
  final db = await database;

  return await db.update(
    'users',
    {'password': newPassword},
    where: 'userName = ?',
    whereArgs: [userName],
  );
}
  Future<void> insertDB(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> accountsList = [
      {
        'name': 'Bank of India',
        'balance': 25000.0,
        'iconCode': Icons.account_balance.codePoint,
        'userId':userId
      },
      {
        'name': 'Paytm Wallet',
        'balance': 1200.0,
        'iconCode': Icons.wallet.codePoint,
        'userId':userId
      },
    ];
    Batch batch = db.batch();

    for (var account in accountsList) {
      batch.insert('account', account);
    }

    await batch.commit(noResult: true);
  }

  Future<List<Map<String, dynamic>>> getAccounts(int userId) async {
    final db = await database;
    return db.query('account',
    where:'userId = ?',
    whereArgs:[userId]
    );
  }

  Future<void> insertAccount(Map<String,dynamic> account) async{
      final db = await database;
      db.insert('account', account);
  }

  Future<void> deleteAccount(int id)async{
      final db = await database;
      db.delete('account',
        where : 'id = ?',
        whereArgs: [id]
      );
  }

  Future<void> updateAccount(Map<String,dynamic> account)async{
    final db = await database;
    int id = account['id'];
    db.update('account',
     account,
     where: 'id = ?',
     whereArgs : [id]
    );
  }   

Future<void> updateAccountBalance(int id, double newBalance , int userId)async{
  final db = await database;
  await db.update('account',
  {'balance' : newBalance},
  where : 'id = ? AND userId = ?',
  whereArgs: [id,userId],
  );
}

////////////////////////////// categories

  Future<void> insertCategories(int id) async {
        final db = await database;
    try {
      final List<Map<String, dynamic>> categoryList = [
        {
          'name': 'Shopping',
          'iconCode': Icons.shopping_bag.codePoint,
          'color': Colors.pink.value,
          'type': 'Expense',
          'expense': 0.0,
          'userId':id
        },
          {
          'name': 'Salary',
          'iconCode': Icons.account_balance_wallet.codePoint,
          'color': Colors.green.value,
          'type': 'Income',
          'expense': 0.0,
          'userId':id
        },
        {
          'name': 'Food & Dining',
          'iconCode': Icons.restaurant.codePoint,
          'color': Colors.orange.value,
          'type': 'Expense',
          'expense': 0.0,
          'userId':id
        },
        {
          'name': 'Transport',
          'iconCode': Icons.directions_car.codePoint,
          'color': Colors.blue.value,
          'type': 'Expense',
          'expense': 0.0,
          'userId':id
        },
        {
          'name': 'Bills',
          'iconCode': Icons.receipt_long.codePoint,
          'color': Colors.red.value,
          'type': 'Expense',
          'expense': 0.0,
          'userId':id
        },
        {
          'name': 'Mobile Recharge',
          'iconCode': Icons.phone_android.codePoint,
          'color': Colors.purple.value,
          'type': 'Expense',
          'expense': 0.0,
          'userId':id
        },
        {
          'name': 'Entertainment',
          'iconCode': Icons.movie.codePoint,
          'color': Colors.deepPurple.value,
          'type': 'Expense',
          'expense': 0.0,
          'userId':id
        },
        {
          'name': 'Grocery Store',
          'iconCode': Icons.local_grocery_store.codePoint,
          'color': Colors.teal.value,
          'type': 'Expense',
          'expense': 0.0,
          'userId':id
        },
        {
          'name': 'Tea & Coffee',
          'iconCode': Icons.coffee.codePoint,
          'color': Colors.brown.value,
          'type': 'Expense',
          'expense': 0.0,
          'userId':id
        },
      ];

      Batch batch = db.batch();

      for (var category in categoryList) {
        batch.insert('categories', category);
      }

      await batch.commit(noResult: true);
     
    } catch (e) {
      log(" Error inserting categories: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getCategories(int userId) async {
    final db = await database;
    return db.query(
      'categories',
      where: 'userId = ?',
      whereArgs: [userId]
    );
  }

  Future<void> updateCategoryExpense(int id ,double expenses , int userId) async{
  final db = await database;
   await db.update(
      'categories',
      {'expense': expenses},
      where : 'id = ? AND userId = ?',
      whereArgs:[id,userId]
    );
 }

///////////////////////////////// expenses ////

Future<void> insertExpenses(Map<String,dynamic> expenses)async{
  final db = await database;
  db.insert('expenses',expenses);
}

  Future<List<Map<String, dynamic>>> getExpenses(int userId) async {
    log('get expense id $userId');
    final db = await database;
    return await db.rawQuery('''
    SELECT e.*, c.name as categoryName, a.name as accountName 
    FROM expenses e
    LEFT JOIN categories c ON e.categoryId = c.id
    LEFT JOIN account a ON e.accountId = a.id
    WHERE e.userId = ?
  ''', [userId]);
  }

  Future<void> deleteExpense(int id)async{
    final db = await database;
    await db.delete('expenses',
    where : 'id = ?',
    whereArgs:[id]
    );
  }

}

