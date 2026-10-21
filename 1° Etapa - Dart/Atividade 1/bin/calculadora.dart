import 'dart:io';

void main() {

stdout.write("Digite o valor do seu salário mensal: ");
double salario = double.parse(stdin.readLineSync()!);
double imposto;
double salario_liquido;

if(salario <= 2000.00){
imposto = 0;
salario_liquido = salario - imposto;

print("valor descontado do imposto: $imposto");
print("salário líquido final: $salario_liquido");
}

else if(salario >= 2000.01 && salario <= 4000){
imposto = salario * 0.07;
salario_liquido = salario - imposto;

print("valor descontado do imposto: $imposto");
print("salário líquido final: $salario_liquido");
}

else {
imposto = salario * 0.15;
salario_liquido = salario - imposto;

print("valor descontado do imposto: $imposto");
print("salário líquido final: $salario_liquido");
}

}