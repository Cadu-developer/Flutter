import 'package:sqflite/sqflite.dart';
import '../models/usuario.dart';

class UsuarioService {
  static Database? _banco;

  Future<Database> get banco async {
    if (_banco != null) return _banco!;

    _banco = await openDatabase(
      'controle_estoque.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE usuarios (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            senha TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE produtos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL,
            categoria TEXT NOT NULL,
            quantidade INTEGER NOT NULL,
            preco REAL NOT NULL
          )
        ''');
      },
    );

    return _banco!;
  }

  Future<bool> emailExiste(String email) async {
    final db = await banco;

    final resultado = await db.query(
      'usuarios',
      where: 'email = ?',
      whereArgs: [email],
    );

    return resultado.isNotEmpty;
  }

  Future<bool> cadastrarUsuario(Usuario usuario) async {
    final db = await banco;

    if (await emailExiste(usuario.email)) {
      print('SELECT → E-mail já cadastrado: ${usuario.email}');
      return false;
    }

    await db.insert('usuarios', usuario.toMap());

    print('INSERT → Usuário cadastrado: ${usuario.nome}');
    return true;
  }

  Future<Usuario?> login(String email, String senha) async {
    final db = await banco;

    print('SELECT → Procurando usuário: $email');

    final resultado = await db.query(
      'usuarios',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );

    if (resultado.isNotEmpty) {
      final usuario = Usuario.fromMap(resultado.first);
      print('SELECT → Usuário encontrado: ${usuario.nome}');
      return usuario;
    }

    print('SELECT → Usuário não encontrado');
    return null;
  }
}