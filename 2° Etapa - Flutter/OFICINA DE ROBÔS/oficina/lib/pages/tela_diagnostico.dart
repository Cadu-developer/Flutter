import 'package:flutter/material.dart';

class TelaDiagnostico extends StatelessWidget {
  final String nomeRobo;
  final double energia;
  final int pecasInstaladas;
  final String resultadoTeste;

  const TelaDiagnostico({
    super.key,
    required this.nomeRobo,
    required this.energia,
    required this.pecasInstaladas,
    required this.resultadoTeste,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnóstico'),
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
                      const Icon(Icons.assessment, size: 64, color: Colors.blue),
                      const SizedBox(height: 16),
                      Text(
                        'Relatório do Robô',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const Divider(height: 32),
                      Text('Nome do Robô: $nomeRobo', style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      Text('Energia Atual: ${energia.toInt()}%', style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      Text('Peças Instaladas: $pecasInstaladas', style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      Text('Último Teste: $resultadoTeste', style: const TextStyle(fontSize: 18)),
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