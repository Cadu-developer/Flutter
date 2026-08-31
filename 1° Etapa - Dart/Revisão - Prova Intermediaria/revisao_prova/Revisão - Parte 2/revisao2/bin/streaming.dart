import 'dart:io';

class PerfilAssistindo {
  int _minutosAssistidos = 0;
  int get minutosAssistidos => _minutosAssistidos;
  
  set minutosAssistidos(int valor) {
    if (valor >= 0) {
      _minutosAssistidos = valor;
    } 

    else {
      print("Tempo não pode ser negativo!");
    }
  }
}

    void main() {

  String? nomeFilme;

  print("O que você quer assistir?");

  String? entrada = stdin.readLineSync();
  nomeFilme = entrada ?? "Documentário Padrão";

  print("Quanto tempo você vai assistir?");

  try {
    String? tempoInput = stdin.readLineSync();
    int tempo = int.parse(tempoInput!);

    PerfilAssistindo perfil = PerfilAssistindo();
    perfil.minutosAssistidos = tempo;

    print("Assistindo: $nomeFilme");
    print("Tempo: ${perfil.minutosAssistidos} minutos");
  }

   catch (e) {
    print("Erro: Digite apenas números inteiros!");
  }
}


