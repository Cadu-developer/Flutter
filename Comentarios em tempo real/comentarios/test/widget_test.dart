import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comentarios/models/comentario.dart';

void main() {
  test('converte os dados do comentário corretamente', () {
    final comentario = Comentario.fromMap('comentario-1', {
      'texto': 'Olá!',
      'nome': 'Maria',
      'uid': 'uid-maria',
      'publicacaoId': 'publicacao-1',
      'data': Timestamp.fromDate(DateTime(2026, 10, 21)),
    });

    expect(comentario.id, 'comentario-1');
    expect(comentario.texto, 'Olá!');
    expect(comentario.nome, 'Maria');
    expect(comentario.uid, 'uid-maria');
    expect(comentario.publicacaoId, 'publicacao-1');
  });
}
