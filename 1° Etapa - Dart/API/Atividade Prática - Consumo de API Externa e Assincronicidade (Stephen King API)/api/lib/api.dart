class Livro {
  String titulo;
  int paginas;
  List<String> viloes;

  Livro({
    required this.titulo,
    required this.paginas,
    required this.viloes,
  });

  void exibirDetalhes() {
    print("📖 Título: $titulo");
    print("📄 Páginas: $paginas");
    print("🦹 Vilões: ${viloes.join(", ")}");
    print("-----------------------------");
  }
}