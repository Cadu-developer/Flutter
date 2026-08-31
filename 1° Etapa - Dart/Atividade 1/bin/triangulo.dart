import 'dart:io';

void main() {


stdout.write("Digite o valor do lado A: ");
int a = int.parse(stdin.readLineSync()!);

stdout.write("Digite o valor do lado B: ");
int b = int.parse(stdin.readLineSync()!);

stdout.write("Digite o valor do lado C: ");
int c = int.parse(stdin.readLineSync()!);

 if (a + b > c && a + c > b && b + c > a) {

    if (a == b && b == c) {
      print("O tipo do triângulo é Equilátero");
    } 
    else if (a == b || a == c || b == c) {
      print("O tipo do triângulo é Isósceles");
    } 
    else {
      print("O tipo do triângulo é Escaleno");
    }

  } else {
    print("Não é um triângulo!");
  }
}



