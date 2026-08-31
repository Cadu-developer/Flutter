import 'package:flutter/material.dart';

class CartaoPeca extends StatelessWidget {
  final IconData icone;
  final String nome;
  final bool instalada;
  final VoidCallback aoApertarBotao;

  const CartaoPeca({
    super.key,
    required this.icone,
    required this.nome,
    required this.instalada,
    required this.aoApertarBotao,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: instalada ? Colors.green.shade100 : Colors.red.shade100,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icone, size: 40),
            const SizedBox(height: 8),
            Text(
              nome,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text('Situação: ${instalada ? "Instalada" : "Não instalada"}'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: aoApertarBotao,
              child: Text(instalada ? 'Remover' : 'Instalar'),
            ),
          ],
        ),
      ),
    );
  }
}