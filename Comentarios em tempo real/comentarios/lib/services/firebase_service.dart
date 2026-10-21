
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  User get usuario {
    final user = auth.currentUser;

    if (user == null) {
      throw Exception('Usuário não autenticado.');
    }

    return user;
  }

  CollectionReference<Map<String, dynamic>>
      get publicacoes => db.collection('publicacoes');

  Future<void> criarPublicacao(String texto) async {
    final user = usuario;
    final conteudo = texto.trim();

    if (conteudo.isEmpty) return;

    await publicacoes.add({
      'texto': conteudo,
      'uid': user.uid,
      'nome': user.displayName ?? 'Usuário',
      'data': FieldValue.serverTimestamp(),
    });
  }

  CollectionReference<Map<String, dynamic>>
      comentarios(String publicacaoId) {
    return publicacoes
        .doc(publicacaoId)
        .collection('comentarios');
  }

  Future<void> criarComentario({
    required String publicacaoId,
    required String texto,
  }) async {
    final user = usuario;
    final conteudo = texto.trim();

    if (conteudo.isEmpty) return;

    await comentarios(publicacaoId).add({
      'texto': conteudo,
      'uid': user.uid,
      'nome': user.displayName ?? 'Usuário',
      'publicacaoId': publicacaoId,
      'data': FieldValue.serverTimestamp(),
    });
  }

  Future<void> excluirComentario({
    required String publicacaoId,
    required String comentarioId,
  }) async {
    final user = usuario;
    final ref = comentarios(publicacaoId).doc(comentarioId);

    final documento = await ref.get();

    if (!documento.exists) {
      throw Exception('Comentário não encontrado.');
    }

    if (documento.data()?['uid'] != user.uid) {
      throw Exception(
        'Você só pode excluir seus próprios comentários.',
      );
    }

    await ref.delete();
  }
}
