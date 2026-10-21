import 'dart:io';

abstract class Pagamento {
  double valor_original;

  Pagamento(this.valor_original);

  double processar();
}

class Cartao extends Pagamento {
  Cartao(double valor_original) : super(valor_original);

  @override
  double processar() {
    return valor_original * 1.02;
  }
}

class Pix extends Pagamento {
  Pix(double valor_original) : super(valor_original);

  @override
  double processar() {
    return valor_original * 0.90;
  }
}

void main() {
  print("Digite seu saldo: ");
  double saldoConta = double.parse(stdin.readLineSync()!);

  print("Digite o valor da compra: ");
  double valorCompra = double.parse(stdin.readLineSync()!);

  print("Qual a forma de pagamento? (1-Cartão / 2-Pix)");
  String? opcao = stdin.readLineSync();

  Pagamento pagamento;

  if (opcao == "1") {
    pagamento = Cartao(valorCompra);
  }

  else if (opcao == "2") {
    pagamento = Pix(valorCompra);
  } 

  else {
    print("Forma de pagamento inválida.");
    return;
  }

  double valorFinal = pagamento.processar();

  if (valorFinal <= saldoConta) {
    double saldoRestante = saldoConta - valorFinal;

    print("Pagamento de R\$ $valorFinal aprovado! Saldo restante: R\$ $saldoRestante");
  }

  else {
    double faltou = valorFinal - saldoConta;
    print("Pagamento negado! Saldo insuficiente. Faltam R\$ $faltou");
  }
}