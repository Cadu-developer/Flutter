import 'dart:io';

void main() {

  stdout.write("Digite a temperatura: ");
  double temperatura = double.parse(stdin.readLineSync()!);

  stdout.write("Escolha a opção:\n");
  stdout.write("1 - Celsius para Fahrenheit\n");
  stdout.write("2 - Fahrenheit para Celsius\n");
  stdout.write("3 - Celsius para Kelvin\n");
  stdout.write("Opção: ");

  int opcao = int.parse(stdin.readLineSync()!);

  switch(opcao) {

    case 1:
      double fahrenheit = (temperatura * 1.8) + 32;
      print("Celsius para Fahrenheit: $fahrenheit");

      break;

    case 2:
      double celsius = (temperatura - 32) / 1.8;
      print("Fahrenheit para Celsius: $celsius");

      break;

    case 3:
      double kelvin = temperatura + 273.15;
      print("Celsius para Kelvin: $kelvin");
      
      break;

    default:
      print("Opção inválida!");
  }
}
