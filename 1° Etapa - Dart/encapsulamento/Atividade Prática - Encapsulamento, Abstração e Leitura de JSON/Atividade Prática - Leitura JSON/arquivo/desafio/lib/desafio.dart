class Conteudo {
  int id;
  String titulo;

  List<double> avaliacoes = [];

  Conteudo(this.id, this.titulo);

  void avaliar(double nota) {
    if (nota >= 1 && nota <= 5) {
      avaliacoes.add(nota);
    }
  }

  double get notaMedia {
    if (avaliacoes.isEmpty) return 0;

    double soma = 0;
    for (var n in avaliacoes) {
      soma += n;
    }

    return soma / avaliacoes.length;
  }

  String get estrelas {
    return '⭐' * notaMedia.round();
  }
}
