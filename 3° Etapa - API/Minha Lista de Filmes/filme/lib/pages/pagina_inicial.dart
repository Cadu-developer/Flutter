import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/filme_viewmodel.dart';

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Carregamento inicial automático ao abrir a tela
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FilmeViewModel>(context, listen: false).carregarFilmes();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FilmeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Lista de Filmes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Digite o nome do filme',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    viewModel.adicionarFilme(_controller.text);
                    _controller.clear();
                  }
                },
                child: const Text('Adicionar'),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            Expanded(
              child: viewModel.filmes.isEmpty
                  ? const Center(
                      child: Text('Nenhum filme cadastrado ainda.'),
                    )
                  : ListView.builder(
                      itemCount: viewModel.filmes.length,
                      itemBuilder: (context, index) {
                        final filme = viewModel.filmes[index];
                        return ListTile(
                          leading: Text('${filme.id ?? (index + 1)}'),
                          title: Text(
                            filme.titulo,
                            style: TextStyle(
                              decoration: filme.assistido
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: filme.assistido ? Colors.grey : Colors.black,
                            ),
                          ),
                          trailing: Checkbox(
                            value: filme.assistido,
                            onChanged: (bool? valor) {
                              if (valor != null) {
                                viewModel.alterarStatus(filme, valor);
                              }
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}