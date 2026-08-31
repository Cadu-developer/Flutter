class Serie {
  String nome, genero, profissao, frase_famosa;
  int idade;

  Serie(this.nome, this.genero, this.profissao, this.idade, this.frase_famosa);

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'genero': genero,
      'profissao': profissao,
      'frase_famosa': frase_famosa,
      'idade': idade,
    };
  }
}

