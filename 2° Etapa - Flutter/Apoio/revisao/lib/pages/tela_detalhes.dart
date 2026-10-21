import 'package:flutter/material.dart';

class TelaDetalhes extends StatelessWidget {
  const TelaDetalhes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de Detalhes'),
      ), // AppBar

      // por padrão o navigator.push nos dá um voltar se estiver no appbar

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.info,
                size: 80,
                color: Colors.amber,
              ), // Icon

              const SizedBox(height: 20),

              const Text(
                'Você chegou na segunda tela!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ), // TextStyle
                textAlign: TextAlign.center,
              ), // Text

              const SizedBox(height: 10),

              const Text(
                'Essa tela foi aberta usando Navigator.push.',
                textAlign: TextAlign.center,
              ), // Text

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context); // voltar para a página anterior
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Voltar'),
              ), // ElevatedButton.icon
            ],
          ), // Column
        ), // Padding
      ), // SafeArea
    ); // Scaffold
  }
}