import 'dart:core';

abstract class ItemColecao {
  int id;
  String titulo, _autor;

  ItemColecao(this.id, this.titulo, String autor) : _autor = '' {
    this.autor = autor; 
  }

  String get autor => _autor;

  set autor(String valor) {
    if (valor.isEmpty || valor.length < 3) {
      throw Exception('Autor inválido!');
    }
    _autor = valor;
  }

  Map<String, dynamic> toJson();
}

// Classe Livro herda de ItemColecao
class Livro extends ItemColecao {
  int paginas;

  Livro(int id, String titulo, String autor, this.paginas)
      : super(id, titulo, autor);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'autor': autor,
      'paginas': paginas,
    };
  }  

  //Cria o objeto da classe Livro a partir de biblioteca.JSON
  factory Livro.fromJson(Map<String, dynamic> json) {
    return Livro(
      json['id'],
      json['titulo'],
      json['autor'],
      json['paginas'],
    );
  }
}