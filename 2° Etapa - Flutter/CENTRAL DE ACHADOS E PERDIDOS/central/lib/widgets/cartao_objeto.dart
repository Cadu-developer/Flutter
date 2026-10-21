import 'package:flutter/material.dart';

class CartaoObjeto extends StatelessWidget {
  final String nome;
  final String local;
  final String situacao;
  final Color cor;
  final VoidCallback aoApertarBotao;

  const CartaoObjeto({
    super.key,
    required this.nome,
    required this.local,
    required this.situacao,
    required this.cor,
    required this.aoApertarBotao,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(Icons.inventory_2, size: 48),
            const SizedBox(height: 8),
            Text(
              nome,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text('Local: $local', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            Text(
              'Situação: $situacao',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: aoApertarBotao,
              child: Text(
                situacao == 'Aguardando retirada'
                    ? 'Marcar como Devolvido'
                    : 'Desfazer Alteração',
              ),
            ),
          ],
        ),
      ),
    );
  }
}