class Filme {
  final int? id;
  final String titulo;
  final bool assistido;

  Filme({
    this.id,
    required this.titulo,
    required this.assistido,
  });

  // Converte um Map do SQLite para o objeto Filme
  factory Filme.fromMap(Map<String, dynamic> map) {
    return Filme(
      id: map['id'],
      titulo: map['titulo'],
      assistido: map['assistido'] == 1,
    );
  }

  // Converte o objeto Filme para um Map para salvar no SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'assistido': assistido ? 1 : 0,
    };
  }

  // Método auxiliar para criar cópias alterando propriedades específicas
  Filme copyWith({
    int? id,
    String? titulo,
    bool? assistido,
  }) {
    return Filme(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      assistido: assistido ?? this.assistido,
    );
  }
}