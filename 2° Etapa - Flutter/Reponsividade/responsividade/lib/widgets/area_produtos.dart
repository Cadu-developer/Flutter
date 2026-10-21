import 'package:flutter/material.dart';

import '../models/produto.dart';
import 'produto_card.dart';

class AreaProdutos extends StatelessWidget {
  final List<Produto> produtos;
  final int colunas;
  final double alturaCard;

  const AreaProdutos({
    super.key,
    required this.produtos,
    required this.colunas,
    required this.alturaCard,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Produtos em destaque',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: produtos.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: colunas,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            mainAxisExtent: alturaCard,
          ),
          itemBuilder: (context, index) {
            final produto = produtos[index];

            return ProdutoCard(
              icone: produto.icone,
              nome: produto.nome,
              descricao: produto.descricao,
              preco: produto.preco,
            );
          },
        ),
      ],
    );
  }
}
