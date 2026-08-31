import 'dart:io';

void main() {
stdout.write("Digite um ano: ");
int ano = int.parse(stdin.readLineSync()!);

if(ano % 4 == 0 && ano % 100 != 0 || ano % 400 == 0){
    print("O ano é Bissexto!");
}

else {
    print("O ano não é Bissexto!");
}

}