import 'package:combate/combate.dart' as combate;
import 'dart:io';

void main(List<String> arguments) {
var vida_heroi = 100;
var vida_monstro = 100;
var ataque_heroi = 15;
var ataque_monstro = 12;
int turno = 1;

while(vida_heroi > 0 && vida_monstro > 0){
  print("Rodada $turno");

   vida_monstro -= ataque_heroi;
    print("Herói atacou o Monstro causando $ataque_heroi de dano.");

    if (vida_monstro <= 0) {
      print("O Monstro foi derrotado!");
    }

    vida_heroi -= ataque_monstro;
    print("Monstro atacou o Heroi causando $ataque_monstro de dano.");

    if (vida_heroi <= 0) {
      print("O Heroi foi derrotado!");
    }


    print("Vida do Herói: $vida_heroi");
    print("Vida do Monstro: $vida_monstro");

turno++;
print("\n");
}

if(vida_heroi > vida_monstro){
  print("Heroi Venceu");
}

else{
  print("Monstro venceu!");
}

}
