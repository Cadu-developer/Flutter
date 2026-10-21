import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const EscolaJujutsuApp());
}

class EscolaJujutsuApp extends StatelessWidget {
  const EscolaJujutsuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Escola Jujutsu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const VerificadorLogin(),
    );
  }
}

class VerificadorLogin extends StatelessWidget {
  const VerificadorLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == null) {
          return const TelaLogin();
        }

        return const CentralJujutsu();
      },
    );
  }
}

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  bool carregando = false;

  Future<void> entrarComGoogle() async {
    setState(() => carregando = true);

    try {
      final GoogleSignInAccount? conta =
          await GoogleSignIn().signIn();

      if (conta == null) return;

      final GoogleSignInAuthentication googleAuth =
          await conta.authentication;

      final credencial = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(
        credencial,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Falha no login: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => carregando = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.shield,
                  size: 88,
                  color: Colors.deepPurple,
                ),
                const SizedBox(height: 20),
                Text(
                  'ESCOLA JUJUTSU',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text('Acesso restrito para feiticeiros'),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed:
                        carregando ? null : entrarComGoogle,
                    icon: const Icon(Icons.login),
                    label: Text(
                      carregando
                          ? 'Entrando...'
                          : 'ENTRAR COM GOOGLE',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CentralJujutsu extends StatelessWidget {
  const CentralJujutsu({super.key});

  User get usuario => FirebaseAuth.instance.currentUser!;

  CollectionReference<Map<String, dynamic>> get missoes =>
      FirebaseFirestore.instance.collection('missoes');

  Future<void> sair() async {
    try {
      await GoogleSignIn().signOut();
    } finally {
      await FirebaseAuth.instance.signOut();
    }
  }

  Future<void> cadastrarMissao(
    String titulo,
    int grau,
  ) async {
    await missoes.add({
      'titulo': titulo.trim(),
      'grau': grau,
      'concluida': false,
      'usuarioId': usuario.uid,
    });
  }

  Future<void> alterarConclusao(
    String id,
    bool concluida,
  ) async {
    await missoes.doc(id).update({
      'concluida': concluida,
    });
  }

  Future<void> excluirMissao(String id) async {
    await missoes.doc(id).delete();
  }

  Future<void> abrirCadastro(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final tituloController = TextEditingController();
    int grauSelecionado = 2;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, atualizarDialogo) => AlertDialog(
          title: const Text('Registrar missão'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: tituloController,
                  decoration: const InputDecoration(
                    labelText: 'Título da missão',
                    hintText: 'Investigar maldição na escola',
                  ),
                  validator: (valor) {
                    if (valor == null || valor.trim().isEmpty) {
                      return 'Informe o título da missão';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: grauSelecionado,
                  decoration: const InputDecoration(
                    labelText: 'Grau da missão',
                  ),
                  items: [1, 2, 3, 4].map((grau) {
                    return DropdownMenuItem(
                      value: grau,
                      child: Text('Grau $grau'),
                    );
                  }).toList(),
                  onChanged: (valor) {
                    if (valor != null) {
                      atualizarDialogo(
                        () => grauSelecionado = valor,
                      );
                    }
                  },
                ),
              ],
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
                  await cadastrarMissao(
                    tituloController.text,
                    grauSelecionado,
                  );

                  if (dialogContext.mounted) {
                    Navigator.pop(dialogContext);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Missão registrada!'),
                      ),
                    );
                  }
                } catch (e) {
                  if (dialogContext.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erro: $e')),
                    );
                  }
                }
              },
              child: const Text('Salvar missão'),
            ),
          ],
        ),
      ),
    );

    tituloController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final consulta = missoes
        .where('usuarioId', isEqualTo: usuario.uid)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Central Jujutsu'),
        actions: [
          IconButton(
            tooltip: 'Sair da conta',
            onPressed: sair,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => abrirCadastro(context),
        icon: const Icon(Icons.add),
        label: const Text('Nova missão'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: ListTile(
              leading: CircleAvatar(
                radius: 28,
                backgroundImage: usuario.photoURL != null
                    ? NetworkImage(usuario.photoURL!)
                    : null,
                child: usuario.photoURL == null
                    ? const Icon(Icons.person)
                    : null,
              ),
              title: Text(
                'Bem-vindo,\n${usuario.displayName ?? 'Feiticeiro'}',
              ),
              subtitle: Text(usuario.email ?? ''),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Suas missões',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<
                QuerySnapshot<Map<String, dynamic>>>(
              stream: consulta,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Erro ao carregar suas missões.'),
                  );
                }

                if (snapshot.connectionState ==
                        ConnectionState.waiting &&
                    !snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final documentos = snapshot.data?.docs ?? [];

                if (documentos.isEmpty) {
                  return const Center(
                    child: Text('Você ainda não possui missões.'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 90),
                  itemCount: documentos.length,
                  itemBuilder: (context, index) {
                    final doc = documentos[index];
                    final dados = doc.data();
                    final titulo =
                        (dados['titulo'] ?? '').toString();
                    final grau = (dados['grau'] as num?) ?? 0;
                    final concluida =
                        dados['concluida'] == true;

                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                          value: concluida,
                          onChanged: (valor) async {
                            try {
                              await alterarConclusao(
                                doc.id,
                                valor ?? false,
                              );
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                    content: Text('Erro: $e'),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                        title: Text(
                          titulo,
                          style: TextStyle(
                            decoration: concluida
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        subtitle: Text(
                          'Grau $grau • '
                          '${concluida ? 'Concluída' : 'Pendente'}',
                        ),
                        trailing: IconButton(
                          tooltip: 'Excluir missão',
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () async {
                            try {
                              await excluirMissao(doc.id);
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                    content: Text('Erro: $e'),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}