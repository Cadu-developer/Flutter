import 'package:flutter/material.dart';

class TelaComprovante extends StatelessWidget {
  final String nome;
  final String local;
  final String situacao;
  final int totalRegistros;

  const TelaComprovante({
    super.key,
    required this.nome,
    required this.local,
    required this.situacao,
    required this.totalRegistros,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comprovante'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double paddingHorizontal = constraints.maxWidth > 600 ? 64.0 : 16.0;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: 16.0),
            child: Center(
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(Icons.receipt_long, size: 64, color: Colors.deepPurple),
                      const SizedBox(height: 16),
                      Text(
                        'Último Objeto Cadastrado',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const Divider(height: 32),
                      Text('Nome: $nome', style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      Text('Local: $local', style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      Text('Situação: $situacao', style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      Text('Total de Registros: $totalRegistros', style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                        child: const Text('Voltar', style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}