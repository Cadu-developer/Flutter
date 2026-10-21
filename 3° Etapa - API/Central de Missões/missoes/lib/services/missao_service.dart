import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/missao.dart';

class MissaoService {
  CollectionReference get _collection =>
      FirebaseFirestore.instance.collection('missoes');

  Future<void> adicionar(Missao missao) async {
    try {
      final docRef = await _collection.add(missao.toMap());
      debugPrint("✅ Sucesso ao salvar! ID: ${docRef.id}");
    } catch (e) {
      debugPrint("❌ ERRO AO SALVAR NO FIRESTORE: $e");
      rethrow;
    }
  }

  Future<List<Missao>> buscarTodas() async {
    try {
      final snapshot = await _collection.get();
      return snapshot.docs.map((doc) {
        return Missao.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      debugPrint("❌ ERRO AO BUSCAR DO FIRESTORE: $e");
      return [];
    }
  }

  Future<void> atualizar(Missao missao) async {
    try {
      if (missao.id != null) {
        await _collection.doc(missao.id).update(missao.toMap());
      }
    } catch (e) {
      debugPrint("❌ ERRO AO ATUALIZAR: $e");
      rethrow;
    }
  }

  Future<void> excluir(String id) async {
    try {
      await _collection.doc(id).delete();
    } catch (e) {
      debugPrint("❌ ERRO AO EXCLUIR: $e");
      rethrow;
    }
  }
}