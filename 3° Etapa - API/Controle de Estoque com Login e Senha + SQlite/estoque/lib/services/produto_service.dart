import 'package:sqflite/sqflite.dart';
import '../models/produto.dart';
import 'usuario_service.dart';

class ProdutoService {
  final UsuarioService _usuarioService = UsuarioService();

  Future<Database> get banco async {
    return await _usuarioService.banco;
  }

  Future<void> cadastrarProduto(Produto produto) async {
    final db = await banco;

    await db.insert('produtos', produto.toMap());

    print('INSERT → Produto cadastrado: ${produto.nome}');
  }

  Future<List<Produto>> listarProdutos() async {
    final db = await banco;

    final resultado = await db.query('produtos');

    print('SELECT → Produtos encontrados:');

    for (final produto in resultado) {
      print(produto);
    }

    return resultado.map((map) => Produto.fromMap(map)).toList();
  }

  Future<void> mostrarProdutosNoTerminal() async {
    final db = await banco;

    final produtos = await db.query('produtos');

    print('===== PRODUTOS NO BANCO =====');

    for (final produto in produtos) {
      print(produto);
    }
  }

  Future<void> alterarQuantidade(int id, int quantidade) async {
    final db = await banco;

    final resultado = await db.query(
      'produtos',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (resultado.isEmpty) return;

    final produto = Produto.fromMap(resultado.first);
    final quantidadeAnterior = produto.quantidade;

    await db.update(
      'produtos',
      {'quantidade': quantidade},
      where: 'id = ?',
      whereArgs: [id],
    );

    print('UPDATE → ${produto.nome}');
    print('Quantidade anterior: $quantidadeAnterior');
    print('Nova quantidade: $quantidade');
  }

  Future<void> excluirProduto(int id) async {
    final db = await banco;

    final resultado = await db.query(
      'produtos',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (resultado.isEmpty) return;

    final produto = Produto.fromMap(resultado.first);

    await db.delete(
      'produtos',
      where: 'id = ?',
      whereArgs: [id],
    );

    print('DELETE → Produto excluído: ${produto.nome}');
  }
}