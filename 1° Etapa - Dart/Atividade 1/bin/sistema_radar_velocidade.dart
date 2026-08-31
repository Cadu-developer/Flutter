import 'dart:io';

void main(List<String> arguments) {
 double percentual;

 stdout.write("Digite a velocidade média: ");
 var velocidadeMedida = double.parse(stdin.readLineSync()!);

 stdout.write("Digite a velocidade máxima da via: ");
 var velocidadeMaximaVia =  double.parse(stdin.readLineSync()!);

 percentual = ((velocidadeMedida - velocidadeMaximaVia) / velocidadeMaximaVia) * 100;

 if(percentual <= 10){
    print("Insento de multa");
 } 

 else if(percentual >= 11 && percentual <= 20){
    print("Multa Leve (RS 130,00)");
 }

 else{
    print("Multa Grave (RS 880,00 + Apreensão da CNH).");
 }
}
