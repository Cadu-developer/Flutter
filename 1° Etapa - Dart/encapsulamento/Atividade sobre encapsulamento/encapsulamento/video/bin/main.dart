import 'filme.dart';

void main() {
  Filme filme = Filme('Matrix', 120);

  try {
    filme.classificacao = 16;
    print("Classificação definida com sucesso!");
  } 
  
  catch (e) {
    print('Erro: $e');
  }

  print("\nDados do filme:");
  print("Título: ${filme.titulo}");
  print("Classificação: ${filme.classificacao}");
  print("Duração: ${filme.duracaoMinutos} minutos");
}
