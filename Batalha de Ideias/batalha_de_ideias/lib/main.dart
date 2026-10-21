
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  CollectionReference<Map<String, dynamic>> get ideias =>
      FirebaseFirestore.instance.collection('ideias');

  Future<void> cadastrarIdeia({
    required String titulo,
    required String descricao,
    required String autor,
  }) async {
    await ideias.add({
      'titulo': titulo.trim(),
      'descricao': descricao.trim(),
      'autor': autor.trim(),
      'votos': 0,
    });
  }

  Future<void> votar(String id) async {
    await ideias.doc(id).update({
      'votos': FieldValue.increment(1),
    });
  }

  Future<void> excluir(String id) async {
    await ideias.doc(id).delete();
  }

  Future<void> abrirCadastro(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final tituloController = TextEditingController();
    final descricaoController = TextEditingController();
    final autorController = TextEditingController();

    String? validar(String? valor) {
      if (valor == null || valor.trim().isEmpty) {
        return 'Este campo é obrigatório';
      }
      return null;
    }

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Nova ideia'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: tituloController,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                  ),
                  validator: validar,
                ),
                TextFormField(
                  controller: descricaoController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                  ),
                  maxLines: 3,
                  validator: validar,
                ),
                TextFormField(
                  controller: autorController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do autor',
                  ),
                  validator: validar,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;

              try {
                await cadastrarIdeia(
                  titulo: tituloController.text,
                  descricao: descricaoController.text,
                  autor: autorController.text,
                );

                if (dialogContext.mounted) {
                  Navigator.pop(dialogContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Ideia cadastrada com sucesso!'),
                    ),
                  );
                }
              } catch (e) {
                if (dialogContext.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro ao cadastrar: $e')),
                  );
                }
              }
            },
            child: const Text('Cadastrar'),
          ),
        ],
      ),
    );

    tituloController.dispose();
    descricaoController.dispose();
    autorController.dispose();
  }

  Future<void> confirmarExclusao(
    BuildContext context,
    String id,
  ) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir ideia?'),
        content: const Text(
          'Essa ação removerá a ideia para todos os usuários.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirmado == true) {
      try {
        await excluir(id);
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao excluir: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('💡 Batalha de Ideias'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => abrirCadastro(context),
        icon: const Icon(Icons.add),
        label: const Text('Nova ideia'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: ideias.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar ideias do Firebase.'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final documentos = snapshot.data?.docs.toList() ?? [];

          documentos.sort((a, b) {
            final votosA = (a.data()['votos'] as num?) ?? 0;
            final votosB = (b.data()['votos'] as num?) ?? 0;
            return votosB.compareTo(votosA);
          });

          if (documentos.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Nenhuma ideia cadastrada ainda.\n'
                  'Seja o primeiro a compartilhar uma!',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final campea = documentos.first;
          final dadosCampea = campea.data();
          final votosCampea = (dadosCampea['votos'] as num?) ?? 0;

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
            children: [
              Card(
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '🏆 IDEIA MAIS VOTADA',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        (dadosCampea['titulo'] ?? 'Sem título').toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$votosCampea ${votosCampea == 1 ? 'voto' : 'votos'}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Todas as ideias',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              for (final doc in documentos)
                _cartaoIdeia(
                  context,
                  doc.id,
                  doc.data(),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _cartaoIdeia(
    BuildContext context,
    String id,
    Map<String, dynamic> dados,
  ) {
    final titulo = (dados['titulo'] ?? 'Sem título').toString();
    final descricao =
        (dados['descricao'] ?? '').toString();
    final autor = (dados['autor'] ?? 'Desconhecido').toString();
    final votos = (dados['votos'] as num?) ?? 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '💡 $titulo',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text('Autor: $autor'),
            const SizedBox(height: 10),
            Text(descricao),
            const SizedBox(height: 14),
            Row(
              children: [
                const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                const SizedBox(width: 6),
                Text(
                  '$votos ${votos == 1 ? 'voto' : 'votos'}',
                ),
                const Spacer(),
                IconButton(
                  tooltip: 'Excluir ideia',
                  onPressed: () => confirmarExclusao(context, id),
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () async {
                  try {
                    await votar(id);
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Erro ao votar: $e'),
                        ),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.how_to_vote),
                label: const Text('VOTAR'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}