import 'dart:io';

void main() {
stdout.write("Digite o valor que você quer sacar: ");
int valor = int.parse(stdin.readLineSync()!);

int notas_100 = valor ~/ 100;
valor = valor % 100;

int notas_50 = valor ~/ 50;
valor = valor % 50;

int notas_10 = valor ~/ 10;
valor = valor % 10;

print("Quantidade de notas de 100: $notas_100");
print("Quantidade de notas de 50: $notas_50");
print("Quantidade de notas de 10: $notas_10");

}

