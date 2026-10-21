
import 'package:cloud_firestore/cloud_firestore.dart';

class Comentario {
  final String id;
  final String texto;
  final String nome;
  final String uid;
  final String publicacaoId;
  final Timestamp? data;

  Comentario({
    required this.id,
    required this.texto,
    required this.nome,
    required this.uid,
    required this.publicacaoId,
    this.data,
  });

  factory Comentario.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return Comentario(
      id: id,
      texto: map['texto'] as String? ?? '',
      nome: map['nome'] as String? ?? 'Usuário',
      uid: map['uid'] as String? ?? '',
      publicacaoId: map['publicacaoId'] as String? ?? '',
      data: map['data'] as Timestamp?,
    );
  }
}
