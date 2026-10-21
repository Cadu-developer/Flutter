import 'dart:convert';
import 'dart:io';
import '../lib/carlos_12400432.dart';

void main() async {
  final file = File('petshop.json');
  List<Holocron> holocron = [];

  // Leitura
  if (await file.exists()) {
    String conteudo = await file.readAsString();
    List dados = jsonDecode(conteudo);
    holocron = dados.map((e) => Holocron.fromJson(e)).toList();
  }

  print("1- Registrar Holocron");
  print("2- Remover do Templo");
  print("0- Encerrar Meditação (Sair)");

  int opcao = int.parse(stdin.readLineSync()!);

  if (opcao == 1) {
    print("Digite o ID:");
    int id = int.parse(stdin.readLineSync()!);

   // Erro de ID duplicado
  if (holocron.any((item) => item.id == id)) {
   throw Exception("Este Holocron já foi registrado no Templo");
  }

    stdout.write("Digite a cor do cristal: ");
    String cristal = stdin.readLineSync()!;

    if(cristal == "Vermelho"){
      holocron.purificarEnergia();
    } 

    //Remover
    else if(opcao == "2") {
      var data = jsonDecode(file.readAsStringSync());

  for (int i = 0; i < data.length; i++) {
    print('$i - ${data[i]['id']}');
  }

  stdout.write('Escolha o ID: ');
  int id = int.parse(stdin.readLineSync()!);

  data.removeAt(id);

  file.writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert(data),
  );

  print('Item deletado com sucesso!');
}
  }

  else if(opcao == "0"){
    print("saindo...");
  }
  
  // Salvamento
  await file.writeAsString(jsonEncode(holocron.map((p) => p.toJson()).toList()));
}
