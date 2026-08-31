import 'package:dispositivo/dispositivo.dart' as dispositivo;

class DispositivoSeguranca {
  String _codigoAcesso = "";

  String get codigoAcesso => _codigoAcesso;

  set codigoAcesso(String novoCodigo) {
    if (novoCodigo.length == 4) {
      _codigoAcesso = novoCodigo;
    } 
    
    else {
      throw Exception("O código deve ter exatamente 4 caracteres!");
    }
  }
}

void main(List<String> arguments) {
  print('Hello world: ${dispositivo.calculate()}!');
}
