


 
void main() {
//Questãp 1
    List<String> comidas = [ "Salgado",  "Suco", "Doce"];

comidas.add("Fruta");
print(comidas.length);

//Questão 2
    Set<String> combo =  {'Pastel', 'Refrigerante', 'Pastel'};

combo.add("Pastel");
combo.add("Milk-shake");
combo.add("Hamburguer");
  print("\n",combo);    

//Questão 3
    Map<String, double> precos = {
        "Coxinha": 5.00,
        "Guaraná": 4.00
    };

    print(precos["\nCoxinha"]);

//Questão 4
      double valorCompra = 40;

   String status = valorCompra > 20 ? "Ganhou um adesivo!" : "Obrigado pela compra!";
 print("\n",status);

//Questão 5
   try {
    String valorTexto = "dez_reais";
     double valor = double.parse(valorTexto);
    print("Valor convertido: $valor");
   } 

  on FormatException {
    print("Erro: Digite apenas números para o valor!");
   }
}

//O que será impresso no console ao exibir esse Set?

//{Pastel, Refrigerante, Milk-shake, Hamburguer}

