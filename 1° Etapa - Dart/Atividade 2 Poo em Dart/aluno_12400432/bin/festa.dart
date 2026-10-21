import 'package:aluno_12400432/aluno_12400432.dart' as festa;

void fazerConvite({required String nome, required String hora}) {
  print("Olá $nome, a festa será às $hora!");
}

void main() {
  fazerConvite(nome: "Carlos", hora: "20h");
  fazerConvite(hora: "18h", nome: "Ana");
}