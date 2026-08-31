import 'package:flutter/material.dart';

/*Esta classe representam os dados de um produto
ELA NÃO DESENHA NADA NA TELA
ela guarda apenas informações */

class Produto {
  final IconData icone;
  final String nome;
  final String descricao;
  final String preco;

  Produto(
    this.icone,
    this.nome,
    this.descricao,
    this.preco,
  );
}
