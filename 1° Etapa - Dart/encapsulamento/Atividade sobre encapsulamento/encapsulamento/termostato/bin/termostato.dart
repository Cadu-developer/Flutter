import 'package:termostato/termostato.dart' as termostato;

class Termostato {
  double _temperatura = 20.0;

  double get temperatura => _temperatura;

  set temperatura(double novaTemperatura) {
    if (novaTemperatura >= 10 && novaTemperatura <= 30) {
      _temperatura = novaTemperatura;
    }
    
     else {
      throw Exception("Temperatura fora dos limites permitidos!");
    }
  }
}

void main(List<String> arguments) {
  print('Hello world: ${termostato.calculate()}!');
}
