import 'dart:io';

void main() {

  stdout.write("Digite um número: ");
  int numero = int.parse(stdin.readLineSync()!);
  bool primo = true;

  if (numero < 2) {

    primo = false;

  } 

  else {
    for (int i = 2; i < numero; i++) {

      if (numero % i == 0) {
        primo = false;
        break; 
      }

    }
  }

  if (primo) {
    print("$numero é um número primo.");
  } 
  
  else {
    print("$numero não é um número primo.");
  }
}
