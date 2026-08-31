import 'dart:io';

abstract class Propulsor {
  void ativar(int potencia);
}

class MotorDobra extends Propulsor {
  @override

  void ativar(int potencia) {
    print("Distorcendo o espaço-tempo na potência $potencia");
  }
}

class PropulsorIonico extends Propulsor {
  @override

  void ativar(int potencia) {
    print("Ejetando íons de xenônio na potência $potencia");
  }
}

void main() {
  String statusMissao() => "Lançamento autorizado!";

  print(statusMissao());

  Propulsor motor = MotorDobra();
  motor.ativar(9);
}