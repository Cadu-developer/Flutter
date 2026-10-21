class Universidade {
  String nome;
  String pais;
  String sigla;

  Universidade(this.nome, this.pais, this.sigla);

  void exibirDetalhes() {
    print('🏛️ Universidade: $nome');
    print('📍 País: $pais ($sigla)');
    print('--------------------------------------------------');
  }
}