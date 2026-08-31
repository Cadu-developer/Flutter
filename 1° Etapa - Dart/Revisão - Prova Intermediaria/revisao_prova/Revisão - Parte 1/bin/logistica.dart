import 'dart:io';

abstract class Encomenda {
  String codigo;
  double peso;

  Encomenda(this.codigo, this.peso);

  String gerarEtiqueta();
}

class EnvioNormal extends Encomenda {
  EnvioNormal(String codigo, double peso) : super(codigo, peso);

  @override
  String gerarEtiqueta() {
    return "Encomenda $codigo confirmada! Prazo de entrega: 10 dias";
  }
}

class EnvioSedex extends Encomenda {
  EnvioSedex(String codigo, double peso) : super(codigo, peso);

  @override
  String gerarEtiqueta() {
    return "Encomenda $codigo confirmada! Prazo de entrega: 2 dias";
  }
}

void main() {
  print("Digite o codigo da sua encomenda:");
  String codigo = stdin.readLineSync()!;

  print("Digite o peso da sua encomenda em kg:");
  double peso = double.parse(stdin.readLineSync()!);

  if (peso > 30) {
    print("Erro: O peso máximo permitido é 30kg");
    return;
  }

  print("Qual o tipo de frete? (1-Normal / 2-Sedex)");
  String? opcao = stdin.readLineSync();

  Encomenda encomenda;

  if (opcao == "1") {
    encomenda = EnvioNormal(codigo, peso);
  } 

  else if (opcao == "2") {
    encomenda = EnvioSedex(codigo, peso);
  } 
  
  else {
    print("Opcao invalida!");
    return;
  }

  print(encomenda.gerarEtiqueta());
}