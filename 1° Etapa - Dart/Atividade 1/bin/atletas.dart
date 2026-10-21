import 'dart:io';

void main() {
stdout.write("Digite a idade do nadador: ");
int idade = int.parse(stdin.readLineSync()!);

if(idade >= 5 && idade <= 10){
    print("Infantil");
}

else if(idade >= 10 && idade <= 17){
    print("Juvenil");
}

else if(idade >= 18 && idade <= 60){
    print("Adulto");
}

else if(idade > 60){
    print("Sênior");
}

else{
    print("Idade invalida!");
}

}