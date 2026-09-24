import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/missao_provider.dart';
import 'detalhes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _tituloController = TextEditingController();
  final _dataController = TextEditingController(text: '23/09/2026');
  String _dificuldadeSelecionada = 'Fácil';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MissaoProvider>(context, listen: false).carregarMissoes();
    });
  }

  void _abrirModalCadastro(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _tituloController,
                decoration: const InputDecoration(labelText: 'Título da missão'),
              ),
              DropdownButtonFormField<String>(
                value: _dificuldadeSelecionada,
                items: ['Fácil', 'Médio', 'Difícil']
                    .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                    .toList(),
                onChanged: (val) {
                  setState(() => _dificuldadeSelecionada = val ?? 'Fácil');
                },
                decoration: const InputDecoration(labelText: 'Dificuldade'),
              ),
              TextField(
                controller: _dataController,
                decoration: const InputDecoration(labelText: 'Data (DD/MM/AAAA)'),
              ),
              const SizedBox(height: 16),
         ElevatedButton(
                onPressed: () async {
                  if (_tituloController.text.isNotEmpty) {
                    try {
                      await Provider.of<MissaoProvider>(context, listen: false)
                          .adicionarMissao(
                        _tituloController.text,
                        _dificuldadeSelecionada,
                        _dataController.text,
                      );
                      _tituloController.clear();
                      if (context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Missão cadastrada com sucesso!')),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Erro ao cadastrar: Verifique as regras do Firebase.')),
                        );
                      }
                    }
                  }
                },
                child: const Text('[ CADASTRAR MISSÃO ]'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CENTRAL DE MISSÕES')),
      body: Consumer<MissaoProvider>(
        builder: (context, provider, child) {
          if (provider.carregando) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.amber.shade100,
                width: double.infinity,
                child: Text(
                  'PONTOS CONQUISTADOS: ${provider.pontosTotal}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.missoes.length,
                  itemBuilder: (ctx, i) {
                    final m = provider.missoes[i];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetalhesPage(missao: m),
                            ),
                          );
                        },
                        title: Text(m.titulo),
                        subtitle: Text(
                          'Dificuldade: ${provider.estrelasPorDificuldade(m.dificuldade)}\nPontos: ${m.pontos} | Data: ${m.data}\nStatus: ${m.concluida ? 'Concluída' : 'Pendente'}',
                        ),
                        isThreeLine: true,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!m.concluida)
                              IconButton(
                                icon: const Icon(Icons.check, color: Colors.green),
                                onPressed: () async {
                                  int pts =
                                      await provider.concluirMissao(m);
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Missão concluída!\nVocê conquistou $pts pontos.')),
                                    );
                                  }
                                },
                              ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                provider.excluirMissao(m.id!);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirModalCadastro(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}