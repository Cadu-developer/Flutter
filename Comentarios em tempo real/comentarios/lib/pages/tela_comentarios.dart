
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/firebase_service.dart';

class ComentariosPage extends StatefulWidget {
  final String publicacaoId;
  final String textoPublicacao;

  const ComentariosPage({
    super.key,
    required this.publicacaoId,
    required this.textoPublicacao,
  });

  @override
  State<ComentariosPage> createState() =>
      _ComentariosPageState();
}

class _ComentariosPageState extends State<ComentariosPage> {
  final service = FirebaseService();
  final controller = TextEditingController();

  bool enviando = false;

  Future<void> enviar() async {
    if (controller.text.trim().isEmpty || enviando) return;

    setState(() => enviando = true);

    try {
      await service.criarComentario(
        publicacaoId: widget.publicacaoId,
        texto: controller.text,
      );

      controller.clear();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao comentar: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => enviando = false);
    }
  }

  Future<void> excluir(String comentarioId) async {
    try {
      await service.excluirComentario(
        publicacaoId: widget.publicacaoId,
        comentarioId: comentarioId,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Não foi possível excluir: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uidAtual = FirebaseAuth.instance.currentUser?.uid;

    final comentariosRef = FirebaseFirestore.instance
        .collection('publicacoes')
        .doc(widget.publicacaoId)
        .collection('comentarios');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comentários'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context)
                .colorScheme
                .surfaceContainerHighest,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Publicação selecionada',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(widget.textoPublicacao),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: StreamBuilder<
                QuerySnapshot<Map<String, dynamic>>>(
              stream: comentariosRef
                  .orderBy('data', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Erro ao carregar comentários.'),
                  );
                }

                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final docs = snapshot.data?.docs ?? [];

                if (docs.isEmpty) {
                  return const Center(
                    child: Text('Seja o primeiro a comentar!'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final dados = doc.data();
                    final souAutor = dados['uid'] == uidAtual;

                    return Card(
                      child: ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Text(
                          dados['nome'] ?? 'Usuário',
                        ),
                        subtitle: Text(
                          dados['texto'] ?? '',
                        ),
                        trailing: souAutor
                            ? IconButton(
                                tooltip: 'Excluir meu comentário',
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                                onPressed: () => excluir(doc.id),
                              )
                            : null,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      minLines: 1,
                      maxLines: 4,
                      textCapitalization:
                          TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        hintText: 'Escreva um comentário...',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => enviar(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    tooltip: 'Enviar comentário',
                    onPressed: enviando ? null : enviar,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
