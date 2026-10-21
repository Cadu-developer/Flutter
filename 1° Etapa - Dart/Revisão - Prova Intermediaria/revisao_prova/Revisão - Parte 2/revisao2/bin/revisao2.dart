import 'package:revisao2/revisao2.dart' as revisao2;

void main(List<String> arguments) {
var precos = [10.0, 20.0, 30.0, 40.0, 50.0];
  int desconto = 5;

for(int i = 0; i <= precos.length; i += 2){
double resultado = precos[i] - desconto;

  print(resultado);
}

// Qual será o tipo da variável que armazena o resultado da subtração (double - int)? Double
}
