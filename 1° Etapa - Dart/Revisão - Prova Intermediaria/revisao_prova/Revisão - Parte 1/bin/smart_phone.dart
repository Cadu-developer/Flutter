import 'dart:io';

abstract class Dispositivo {
  String nome;

  Dispositivo(this.nome);

  String ligar();
}

class Lampada extends Dispositivo {
  int intensidade;

  Lampada(String nome, this.intensidade) : super(nome);

  @override
  String ligar() {
    return "Lâmpada ligada com intensidade $intensidade%";
  }
}

class ArCondicionado extends Dispositivo {
  int temperatura;

  ArCondicionado(String nome, this.temperatura) : super(nome);

  @override
  String ligar() {
    return "Ar-condicionado ligado a $temperatura°C";
  }
}

void main() {
  print("Escolha qual dispositivo quer configurar (1-Lâmpada / 2-Ar)");
  int dispositivoEscolhido = int.parse(stdin.readLineSync()!);

  print("Digite o valor da configuração:");
  int valorConfiguracao = int.parse(stdin.readLineSync()!);

  Dispositivo dispositivo;

  if (dispositivoEscolhido == 1) {
    
    if (valorConfiguracao < 0 || valorConfiguracao > 100) {
      print("Valor Inválido.");
      return;
    }

    dispositivo = Lampada("Lâmpada", valorConfiguracao);
  } 

  else if (dispositivoEscolhido == 2) {

    if (valorConfiguracao < 16 || valorConfiguracao > 30) {
      print("Temperatura fora do limite de segurança");
      return;
    }

    dispositivo = ArCondicionado("Ar Condicionado", valorConfiguracao);
  } 

  else {
    print("Dispositivo inválido.");
    return;
  }

  print(dispositivo.ligar());
}