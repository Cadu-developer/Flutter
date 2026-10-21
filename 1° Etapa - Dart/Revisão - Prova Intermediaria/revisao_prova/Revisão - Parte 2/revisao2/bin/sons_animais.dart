import 'dart:io';

abstract class Instrumento {
  String tocar();
}

class Violao extends Instrumento {
  @override
  String tocar() {
    return "Dó Ré Mi Fá Sol Lá Si";
  }
}

class Bateria extends Instrumento {
  @override
  String tocar() {
    return "Bateria";
  }
}

void main() {
  Instrumento som = Violao();
  Instrumento batera = Bateria();

  print(som.tocar());
  print(batera.tocar());
}