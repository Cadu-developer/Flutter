import 'dart:io';
import 'dart:convert';

import 'package:revisao_prova/revisao_prova.dart';

// Salvando os dados
void salvar(List<Livro> lista) {
  final arquivo = File('./biblioteca.json');

  List<Map<String, dynamic>> dados =
      lista.map((item) => item.toJson()).toList();

  arquivo.writeAsStringSync(jsonEncode(dados));
}

// Carregando os dados
List<Livro> carregar() {
  final arquivo = File('./biblioteca.json');

  if (!arquivo.existsSync()) return [];

  String conteudo = arquivo.readAsStringSync();

  if (conteudo.isEmpty) return [];

  List<dynamic> jsonData = jsonDecode(conteudo);

  return jsonData
      .map<Livro>((item) => Livro.fromJson(item))
      .toList();
}

void main() {
  List<Livro> biblioteca = carregar();

  stdout.write('Digite o ID do livro: ');
  int id = int.parse(stdin.readLineSync()!);

  // Erro de ID duplicado
  if (biblioteca.any((item) => item.id == id)) {
    print('Erro! ID existente');
    return;
  }

  stdout.write('Digite o titulo do livro: ');
  String titulo = stdin.readLineSync()!;

  stdout.write('Digite o autor: ');
  String autor = stdin.readLineSync()!;

  stdout.write('Digite o número de paginas: ');
  int paginas = int.parse(stdin.readLineSync()!);

  try {
    Livro livro = Livro(id, titulo, autor, paginas);

    if (paginas > 500) {
      print("Este é um livro denso!");
    }

    biblioteca.add(livro);

    // Pesquisa
    stdout.write('\nDigite um autor para pesquisar: ');
    String buscaAutor = stdin.readLineSync()!;

    var encontrados = biblioteca
        .where((l) =>
            l.autor.toLowerCase().contains(buscaAutor.toLowerCase()))
        .toList();

    print('\nLivros encontrados:');

    if (encontrados.isEmpty) {
      print('Nenhum livro encontrado.');
    } else {
      for (var l in encontrados) {
        print('${l.titulo} (${l.paginas} paginas)');
      }
    }

     salvar(biblioteca);

    print('\nDados salvos com sucesso!');
  } catch (e) {
    print('Erro: $e');
  }
}