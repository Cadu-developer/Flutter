import 'dart:io';

// Questão 1
abstract class Lutador {
  String nome;
  int vida;

  Lutador(this.nome, this.vida);

  void executarHabilidade(int escolha, Lutador alvo);
}

// Questão 2
class ManaInsuficienteException implements Exception {
  String mensagem;

  ManaInsuficienteException(
      [this.mensagem = "Mana insuficiente para usar Bola de Fogo!"]);

  @override
  String toString() {
    return mensagem;
  }
}

// Questão 3
class Guerreiro extends Lutador {
  Guerreiro(String nome, int vida) : super(nome, vida);

  @override
  void executarHabilidade(int escolha, Lutador alvo) {
    if (escolha == 1) {
      print("$nome usou Soco!");

      alvo.vida -= 10;
    } 

    else if (escolha == 2) {
      print("$nome usou Espadada!");

      alvo.vida -= 25;
    
    } 
    else {
      print("Opção inválida!");
    }
  }
}

class Mago extends Lutador {
  int mana;

  Mago(String nome, int vida, this.mana) : super(nome, vida);

  @override
  void executarHabilidade(int escolha, Lutador alvo) {

    if (escolha == 1) {
      print("$nome usou Cajadada!");

      alvo.vida -= 5;
    } 
    
      
    else if (escolha == 2) {
      if (mana < 20) {
        throw ManaInsuficienteException();
      }

      print("$nome usou Bola de Fogo!");

      alvo.vida -= 40;
      mana -= 20;
    }

     else {
      print("Opção inválida!");
    }
  }
}

// Questão 4
void main() {
  Map<int, Lutador> arena = {};

  arena[1] = Guerreiro("Guerreiro", 100);
  arena[2] = Mago("Mago", 80, 50);

// Questão 5
  while (arena[1]!.vida > 0 && arena[2]!.vida > 0) {

    try {
      print("\nEscolha o ID do atacante (1 ou 2):");
      int atacanteID = int.parse(stdin.readLineSync()!);

      print("Escolha a habilidade (1 ou 2):");
      int habilidade = int.parse(stdin.readLineSync()!);

      Lutador atacante = arena[atacanteID]!;

      Lutador alvo = (atacanteID == 1) ? arena[2]! : arena[1]!;

      atacante.executarHabilidade(habilidade, alvo);
    } 

    on FormatException {
      print("Erro: Digite apenas números!");
    }

    on ManaInsuficienteException catch (e) {
      print(e);
    }
    
     catch (e) {
      print("Erro inesperado: $e");
    } 
    
    finally {
      print("\n------ PLACAR ------");
      print("Vida Guerreiro: ${arena[1]!.vida}");
      print("Vida Mago: ${arena[2]!.vida}");

      if (arena[2] == Mago) {
        print("Mana do Mago: ${(arena[2] as Mago).mana}");
      }
      print("--------------------");
    }
  }

//Questão 6
    print("\nO Mago venceu!");
  if (arena[1]!.vida <= 0) {
  } 

  else {
    print("\nO Guerreiro venceu!");
  }
}