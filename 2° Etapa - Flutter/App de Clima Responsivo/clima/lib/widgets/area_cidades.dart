import 'package:flutter/material.dart';
import '../models/cidade_clima.dart';
import 'cidade_card.dart';

class AreaCidades extends StatelessWidget {
  final List<CidadeClima> cidades;
  final int colunas;

  const AreaCidades({
    super.key,
    required this.cidades,
    required this.colunas,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: cidades.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: colunas,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return CidadeCard(
          cidade: cidades[index],
        );
      },
    );
  }
}