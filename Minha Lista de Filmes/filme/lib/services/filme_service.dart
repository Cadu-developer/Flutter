import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/filme.dart';

class FilmeService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'filmes.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE filmes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT NOT NULL,
            assistido INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  // INSERT: Cadastrar filme
  Future<int> inserirFilme(Filme filme) async {
    final db = await database;
    return await db.insert('filmes', filme.toMap());
  }

  // SELECT: Buscar filmes
  Future<List<Filme>> listarFilmes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('filmes');
    return maps.map((map) => Filme.fromMap(map)).toList();
  }

  // UPDATE: Atualizar status do filme
  Future<int> atualizarFilme(Filme filme) async {
    final db = await database;
    return await db.update(
      'filmes',
      filme.toMap(),
      where: 'id = ?',
      whereArgs: [filme.id],
    );
  }
}