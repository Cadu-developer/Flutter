import 'package:flutter/material.dart';

class ProdutoCard extends StatelessWidget {
  final IconData icone;
  final String nome;
  final String descricao;
  final String preco;

  const ProdutoCard({
    super.key,
    required this.icone,
    required this.nome,
    required this.descricao,
    required this.preco,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icone,
              size: 36,
              color: Colors.indigo,
            ),
            const SizedBox(height: 8),
            FittedBox(
              child: Text(
                nome,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              descricao,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Text(
              preco,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Adicionar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
