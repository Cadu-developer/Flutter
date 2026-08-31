import 'cofre.dart';

void main() {
  CofreDigital cofre = CofreDigital();

  try {
    cofre.codigoAcesso = "12";
  }
  
  catch (e) {
    print("Erro: $e");
  }

  try {
    cofre.codigoAcesso = "1234";
    cofre.abrir("1234");
    cofre.abrir("0000");
  } 
  
  catch (e) {
    print("Erro: $e");
  }
}
