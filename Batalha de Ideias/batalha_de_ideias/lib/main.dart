import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const BatalhaDeIdeiasApp());
}

class BatalhaDeIdeiasApp extends StatelessWidget {
  const BatalhaDeIdeiasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Batalha de Ideias',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const TelaPrincipal(),
    );
  }
}

class TelaPrincipal extends StatelessWidget {
  const TelaPrincipal({super.key});

  final String _colecao = 'ideias';

  CollectionReference<Map<String, dynamic>> get _ideias =>
      FirebaseFirestore.instance.collection('ideias');

  Future<void> _cadastrarIdeia(
    BuildContext context,
  ) async {
    final tituloController = TextEditingController();
    final descricaoController = TextEditingController();
    final autorController = TextEditingController();

    final resultado = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nova ideia'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: tituloController,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    hintText: 'Digite o título da ideia',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descricaoController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    hintText: 'Descreva sua ideia',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: autorController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do autor',
                    hintText: 'Digite seu nome',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () async {
                final titulo = tituloController.text.trim();
                final descricao = descricaoController.text.trim();
                final autor = autorController.text.trim();

                if (titulo.isEmpty ||
                    descricao.isEmpty ||
                    autor.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Preencha todos os campos.',
                      ),
                    ),
                  );
                  return;
                }

                try {
                  await _ideias.add({
                    'titulo': titulo,
                    'descricao': descricao,
                    'autor': autor,
                    'votos': 0,
                  });

                  if (context.mounted) {
                    Navigator.pop(context, true);
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Erro ao cadastrar ideia: $e',
                        ),
                      ),
                    );
                  }
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );

    tituloController.dispose();
    descricaoController.dispose();
    autorController.dispose();

    if (resultado == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ideia cadastrada com sucesso!'),
        ),
      );
    }
  }

  Future<void> _votar(
    BuildContext context,
    String documentId,
  ) async {
    try {
      final referencia = _ideias.doc(documentId);

      await FirebaseFirestore.instance.runTransaction(
        (transaction) async {
          final snapshot = await transaction.get(referencia);

          if (!snapshot.exists) {
            throw Exception('A ideia não existe mais.');
          }

          final dados = snapshot.data() ?? {};
          final votos = (dados['votos'] as num?)?.toInt() ?? 0;

          transaction.update(
            referencia,
            {
              'votos': votos + 1,
            },
          );
        },
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Não foi possível registrar o voto: $e',
            ),
          ),
        );
      }
    }
  }

  Future<void> _excluirIdeia(
    BuildContext context,
    String documentId,
    String titulo,
  ) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir ideia'),
          content: Text(
            'Deseja realmente excluir "$titulo"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );

    if (confirmar != true) {
      return;
    }

    try {
      await _ideias.doc(documentId).delete();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ideia excluída.'),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Erro ao excluir ideia: $e',
            ),
          ),
        );
      }
    }
  }

  Widget _buildRanking(
    BuildContext context,
    List<QueryDocumentSnapshot<Map<String, dynamic>>> documentos,
  ) {
    if (documentos.isEmpty) {
      return const SizedBox.shrink();
    }

    QueryDocumentSnapshot<Map<String, dynamic>>? maisVotada;

    for (final documento in documentos) {
      final dados = documento.data();
      final votos = (dados['votos'] as num?)?.toInt() ?? 0;

      if (maisVotada == null) {
        maisVotada = documento;
      } else {
        final votosAtuais =
            (maisVotada!.data()['votos'] as num?)?.toInt() ?? 0;

        if (votos > votosAtuais) {
          maisVotada = documento;
        }
      }
    }

    if (maisVotada == null) {
      return const SizedBox.shrink();
    }

    final dados = maisVotada.data();
    final titulo = dados['titulo'] ?? 'Sem título';
    final votos = (dados['votos'] as num?)?.toInt() ?? 0;

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      color: Colors.amber.shade50,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Text(
              '🏆',
              style: TextStyle(fontSize: 36),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'IDEIA MAIS VOTADA',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    titulo.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$votos ${votos == 1 ? 'voto' : 'votos'}',
                    style: TextStyle(
                      color: Colors.orange.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIdeiaCard(
    BuildContext context,
    QueryDocumentSnapshot<Map<String, dynamic>> documento,
  ) {
    final dados = documento.data();

    final titulo = dados['titulo']?.toString() ?? 'Sem título';
    final descricao =
        dados['descricao']?.toString() ?? 'Sem descrição';
    final autor = dados['autor']?.toString() ?? 'Autor desconhecido';
    final votos = (dados['votos'] as num?)?.toInt() ?? 0;

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    titulo,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Excluir ideia',
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _excluirIdeia(
                      context,
                      documento.id,
                      titulo,
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Autor: $autor',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              descricao,
              style: const TextStyle(
                fontSize: 15,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.red.shade400,
                ),
                const SizedBox(width: 8),
                Text(
                  '$votos ${votos == 1 ? 'voto' : 'votos'}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                FilledButton.icon(
                  onPressed: () {
                    _votar(context, documento.id);
                  },
                  icon: const Icon(Icons.favorite_border),
                  label: const Text('VOTAR'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('💡 Batalha de Ideias'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _cadastrarIdeia(context),
        icon: const Icon(Icons.add),
        label: const Text('Nova ideia'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _ideias.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Erro ao carregar as ideias:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final documentos = snapshot.data?.docs ?? [];

          return Column(
            children: [
              _buildRanking(context, documentos),
              Expanded(
                child: documentos.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.lightbulb_outline,
                                size: 64,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Nenhuma ideia cadastrada.',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Cadastre a primeira ideia!',
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(
                          bottom: 100,
                        ),
                        itemCount: documentos.length,
                        itemBuilder: (context, index) {
                          return _buildIdeiaCard(
                            context,
                            documentos[index],
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
