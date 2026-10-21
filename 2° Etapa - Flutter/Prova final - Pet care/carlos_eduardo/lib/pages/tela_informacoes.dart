import 'package:flutter/material.dart';
import '/widgets/card_status_pet.dart';
import '/pages/tela_pet.dart';

class Informacoes extends StatelessWidget {
  final String nome;
  final String nomePet;
  final String telefone;

  const Informacoes({
    super.key,
    required this.nome,
    required this.nomePet,
    required this.telefone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Status(),
                  ],
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Pet(),
                      ),
                    );
                  },
                  child: Text('Voltar'),
                ), 
          ],
        ),
      ),
    );
  }
}