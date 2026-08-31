import 'package:aluno_12400432/aluno_12400432.dart' as aluno_12400432;

class Filme {
   final String titulo;
   final String genero;

   
  Filme({required this.titulo, required this.genero});


void apresentarDados() {
  print("Titulo do filme: $titulo");
  print("Gênero do filme: $genero");
}

}

void main() {
  Filme construtor = Filme(titulo: "Diario de um banana", genero: "Comedia");
  construtor.apresentarDados();
}

