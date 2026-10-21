import 'dispositivo.dart';

class CofreDigital extends DispositivoSeguranca {
  void abrir(String tentativa) {
    if (tentativa == codigoAcesso) {
      print("Cofre aberto!");
    } 
    
    else {
      print("Acesso negado!");
    }
  }
}
