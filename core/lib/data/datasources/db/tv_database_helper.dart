import 'dart:async';

// import 'package:ditonton/data/models/movie_table.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/tv_series/tv_series_table.dart';

class TvDatabaseHelper {
  static TvDatabaseHelper? _databaseHelper;
  TvDatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory TvDatabaseHelper() => _databaseHelper ?? TvDatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlistTv = 'watchlisttv';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton2.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlistTv (
        id INTEGER PRIMARY KEY,
        overview TEXT,
        posterPath TEXT,
        name TEXT
      );
    ''');
  }

  Future<int> insertWatchlist(TvSeriesTable tvSeries) async {
    final db = await database;
    return await db!.insert(_tblWatchlistTv, tvSeries.toJson());
  }

  Future<int> removeWatchlist(TvSeriesTable tvSeries) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistTv,
      where: 'id = ?',
      whereArgs: [tvSeries.id],
    );
  }

  Future<Map<String, dynamic>?> getTvById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistTv,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTv() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlistTv);

    return results;
  }
}
