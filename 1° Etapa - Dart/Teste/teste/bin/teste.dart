import 'package:teste/teste.dart' as teste;

void main(List<String> arguments) {
  var calcularDesconto = (double preco) {
    return preco * 0.10;
  };

  double precoProduto = 100.0;
  double valorDesconto = calcularDesconto(precoProduto);

  void exibirRecibo({required String produto, required double preco}) {
    print("--- RECIBO ---");
    print("Produto: $produto");
    print("Preço original: R\$ $preco");
    print("Desconto aplicado: R\$ $valorDesconto");
    print("Total a pagar: R\$ ${subtrair(preco, valorDesconto)}");
  }

  exibirRecibo(produto: "Eu odeio Dart", preco: precoProduto);
}

double subtrair(double a, double b) => a - b;