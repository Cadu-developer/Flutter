import 'dart:io';

abstract class Veiculo {
  String placa;

  Veiculo(this.placa);

  String realizarRevisao();
}

class Carro extends Veiculo {
  int portas;

  Carro(String placa, this.portas) : super(placa);

  @override
  String realizarRevisao() {
    return "Placa: $placa \nPortas: $portas";
  }
}

class Moto extends Veiculo {
  int cilindradas;

  Moto(String placa, this.cilindradas) : super(placa);

  @override
  String realizarRevisao() {
    return "\nPlaca: $placa \nCilindradas: $cilindradas";
  }
}

void main() {
  List<Veiculo> oficina = [];

  int contador = 0;

  while (contador < 3) {
    print("Cadastrar veículo ${contador + 1}");
    print("1 - Carro");
    print("2 - Moto");

    String? tipo = stdin.readLineSync();

    print("Digite a placa:");
    String placa = stdin.readLineSync()!;

    if (tipo == "1") {
      print("Digite o número de portas:");
      int portas = int.parse(stdin.readLineSync()!);

      oficina.add(Carro(placa, portas));
    }

    else if (tipo == "2") {
      print("Digite as cilindradas:");
      int cilindradas = int.parse(stdin.readLineSync()!);

      oficina.add(Moto(placa, cilindradas));
    }

     else {
      print("Tipo inválido.");
    }

    contador++;
  }

   print("\nDigite a placa para buscar:");
   String busca = stdin.readLineSync()!;
   

  bool encontrado = false;

  for (var i in oficina) {
    if (i.placa == busca) {
      print(i.realizarRevisao());
      encontrado = true;
      break;
    }
  }

  if (encontrado == false) {
    print("Veículo não encontrado.");
  }
}