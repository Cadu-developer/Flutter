abstract class Conteudo {
  int id;
  String titulo;
  int classificacao;

  Conteudo(this.id, this.titulo, this.classificacao);

  Map<String, dynamic> toJson();
}

class Filme extends Conteudo {
  Filme(int id, String titulo, int classificacao): super(id, titulo, classificacao);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'classificacao': classificacao,
    };
  }
}

class Serie extends Conteudo {
  int temporadas;

  Serie(int id, String titulo, int classificacao, this.temporadas): super(id, titulo, classificacao);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'classificacao': classificacao,
      'temporadas': temporadas,
    };
  }
}