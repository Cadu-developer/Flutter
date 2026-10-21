import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

void listar(File file) {
final data = jsonDecode(file.readAsStringSync());

for(var item in data) {
  print("Nome: ${item['name']}");
}
}

void pesquisar(File file){
  stdout.write("Digite um nome: ");
  String? pesquisa = stdin.readLineSync();

  final data = jsonDecode(file.readAsStringSync());
  var resultado = data.where((item) =>
      item['name'].toLowerCase().contains(pesquisa!.toLowerCase()));

  if (resultado.isEmpty) {
    print('Nenhum personagem encontrado.');
  } else {
    for (var item in resultado){
      print('Encontrado: ${item['name']}');
    }
  }
}

void deletar(File file) {
  var data = jsonDecode(file.readAsStringSync());

  for (int i = 0; i < data.length; i++) {
    print('$i - ${data[i]['name']}');
  }

  stdout.write('Escolha o índice: ');
  int index = int.parse(stdin.readLineSync()!);

  data.removeAt(index);

  file.writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert(data),
  );

  print('Item deletado com sucesso!');
}



void main(List<String> arguments) async {
  final url = Uri.parse('https://thesimpsonsapi.com/api');
  final file = File('backup_api.json');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      await file.writeAsString(
        const JsonEncoder.withIndent('  ').convert(data),
      );

      print('Dados baixados e salvos com sucesso!');
    } else {
      print('Erro ao buscar dados: ${response.statusCode}');
      return;
    }
  } catch (e) {
    print('Erro: $e');
    return;
  }

  while (true) {
    print('\n----- MENU -----');
    print('1 - Listar tudo');
    print('2 - Pesquisar');
    print('3 - Deletar');
    print('4 - Sair');

    stdout.write("OPÇÃO -> ");
    String? opcao = stdin.readLineSync();

    switch (opcao) {
      case '1':
        listar(file);
        break;

      case '2':
        pesquisar(file);
        break;

      case '3':
        deletar(file);
        break;

      case '4':
        print('Saindo...');
        return;

      default:
        print('Opção inválida!');
    }
  }
}