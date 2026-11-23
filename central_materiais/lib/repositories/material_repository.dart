import '../models/material_evento.dart';
import '../services/database_service.dart';

// Somente esta classe consulta ou altera os registros da tabela materiais.
class MaterialRepository {
  final DatabaseService service;
  MaterialRepository(this.service);

  Future<List<MaterialEvento>> listar() async {
    final db = await service.database;
    final linhas = await db.query('materiais', orderBy: 'nome COLLATE NOCASE');
    return linhas.map((linha) => MaterialEvento.fromMap(linha)).toList();
  }

  Future<bool> existeNome(String nome, {int? ignorarId}) async {
    final db = await service.database;
    final nomeNormalizado = nome.trim().toLowerCase();
    final linhas = await db.query(
      'materiais',
      columns: ['id'],
      where: ignorarId == null
          ? 'nome_normalizado = ?'
          : 'nome_normalizado = ? AND id != ?',
      whereArgs: ignorarId == null
          ? [nomeNormalizado]
          : [nomeNormalizado, ignorarId],
      limit: 1,
    );
    return linhas.isNotEmpty;
  }

  Future<void> inserir(MaterialEvento material) async {
    final db = await service.database;
    await db.insert('materiais', material.toMap());
  }

  Future<void> atualizar(MaterialEvento material) async {
    if (material.id == null) {
      throw ArgumentError('O ID é obrigatório para atualizar um material.');
    }
    final db = await service.database;
    await db.update(
      'materiais',
      material.toMap(),
      where: 'id = ?',
      whereArgs: [material.id],
    );
  }

  Future<void> excluir(int id) async {
    final db = await service.database;
    await db.delete('materiais', where: 'id = ?', whereArgs: [id]);
  }
}
