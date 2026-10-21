import 'termostato.dart';

void main() {
  Termostato t = Termostato();

  try {
    t.temperatura = 25;
    print("Temperatura ajustada para: ${t.temperatura}");

    t.temperatura = 5;
  }
  
  catch (e) {
    print('Erro: $e');
  }
}
