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
    // await db.execute('DROP TABLE IF EXISTS expenses');
    // await db.execute('DROP TABLE IF EXISTS categories');
    // await db.execute('DROP TABLE IF EXISTS account');

    await db.execute('''
          CREATE TABLE account (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL , 
            balance REAL NOT NULL ,
            iconCode INTEGER NOT NULL
          )
        ''');

    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        iconCode INTEGER NOT NULL,
        color INTEGER NOT NULL,
        type TEXT NOT NULL,
        expense REAL NOT NULL
      )
    ''');

    await db.execute('''
          CREATE TABLE expenses (
              id INTEGER PRIMARY KEY AUTOINCREMENT ,
              title TEXT NOT NULL,
              amount REAL NOT NULL,
              date TEXT NOT NULL,
              iconCode INTEGER NOT NULL,
              accountId INTEGER,
              categoryId INTEGER,
              FOREIGN KEY (accountId) REFERENCES account(id),
              FOREIGN KEY (categoryId) REFERENCES categories(id)
          )
      ''');

    await insertDB(db);
    await insertCategories(db);
  }

  Future<void> insertDB(Database db) async {
    final List<Map<String, dynamic>> accountsList = [
      {
        'name': 'Bank of India',
        'balance': 25000.0,
        'iconCode': Icons.account_balance.codePoint,
      },
      {
        'name': 'Paytm Wallet',
        'balance': 1200.0,
        'iconCode': Icons.wallet.codePoint,
      },
    ];
    Batch batch = db.batch();

    for (var account in accountsList) {
      batch.insert('account', account);
    }

    await batch.commit(noResult: true);
  }

  Future<List<Map<String, dynamic>>> getAccounts() async {
    final db = await database;
    return db.query('account');
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

Future<void> updateAccountBalance(int id, double newBalance)async{
  final db = await database;
  await db.update('account',
  {'balance' : newBalance},
  where : 'id = ?',
  whereArgs: [id],
  );
}

////////////////////////////// categories

  Future<void> insertCategories(Database db) async {
    try {
      final List<Map<String, dynamic>> categoryList = [
        {
          'name': 'Shopping',
          'iconCode': Icons.shopping_bag.codePoint,
          'color': Colors.pink.value,
          'type': 'Expense',
          'expense': 0.0,
        },
          {
          'name': 'Salary',
          'iconCode': Icons.account_balance_wallet.codePoint,
          'color': Colors.green.value,
          'type': 'Income',
          'expense': 0.0,
        },
        {
          'name': 'Food & Dining',
          'iconCode': Icons.restaurant.codePoint,
          'color': Colors.orange.value,
          'type': 'Expense',
          'expense': 0.0,
        },
        {
          'name': 'Transport',
          'iconCode': Icons.directions_car.codePoint,
          'color': Colors.blue.value,
          'type': 'Expense',
          'expense': 0.0,
        },
        {
          'name': 'Bills',
          'iconCode': Icons.receipt_long.codePoint,
          'color': Colors.red.value,
          'type': 'Expense',
          'expense': 0.0,
        },
        {
          'name': 'Mobile Recharge',
          'iconCode': Icons.phone_android.codePoint,
          'color': Colors.purple.value,
          'type': 'Expense',
          'expense': 0.0,
        },
        {
          'name': 'Entertainment',
          'iconCode': Icons.movie.codePoint,
          'color': Colors.deepPurple.value,
          'type': 'Expense',
          'expense': 0.0,
        },
        {
          'name': 'Grocery Store',
          'iconCode': Icons.local_grocery_store.codePoint,
          'color': Colors.teal.value,
          'type': 'Expense',
          'expense': 0.0,
        },
        {
          'name': 'Tea & Coffee',
          'iconCode': Icons.coffee.codePoint,
          'color': Colors.brown.value,
          'type': 'Expense',
          'expense': 0.0,
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

  Future<List<Map<String, dynamic>>> getCategories() async {
    final db = await database;
    return db.query('categories');
  }

  Future<void> updateCategoryExpense(int id ,double expenses) async{
  final db = await database;
   await db.update(
      'categories',
      {'expense': expenses},
      where : 'id = ?',
      whereArgs:[id]
    );
 }

///////////////////////////////// expenses ////

Future<void> insertExpenses(Map<String,dynamic> expenses)async{
  final db = await database;
  db.insert('expenses',expenses);
}

  Future<List<Map<String, dynamic>>> getExpenses() async {
    final db = await database;
    return await db.rawQuery('''
      SELECT expenses.*, 
             account.name AS accountName, 
             categories.name AS categoryName 
      FROM expenses
      LEFT JOIN account ON expenses.accountId = account.id
      LEFT JOIN categories ON expenses.categoryId = categories.id
    ''');
  }

  Future<void> deleteExpense(int id)async{
    final db = await database;
    await db.delete('expenses',
    where : 'id = ?',
    whereArgs:[id]
    );
  }

}

