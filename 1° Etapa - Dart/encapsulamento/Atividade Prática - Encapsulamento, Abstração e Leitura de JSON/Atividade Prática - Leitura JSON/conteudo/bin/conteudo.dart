import 'dart:io';
import 'dart:convert';
import '../lib/conteudo.dart';

void main() {
  final file = File('dados.json');

  //READ
  List<Conteudo> catalogo = [];

  if (file.existsSync()) {
    String conteudo = file.readAsStringSync();
    List dados = jsonDecode(conteudo);

    for (var item in dados) {
      Filme filme = Filme(
        item['id'],
        item['titulo'],
        item['classificacao'],
      );
      catalogo.add(filme);
    }
  }

  //CREATE
  print("Digite o ID:");
  int id = int.parse(stdin.readLineSync()!);

  //ID
  for (var c in catalogo) {
    if (c.id == id) {
      throw Exception("Erro: ID já cadastrado no sistema!");
    }
  }

  print("Digite o título:");
  String titulo = stdin.readLineSync()!;

  print("Digite a classificação:");
  int classificacao = int.parse(stdin.readLineSync()!);

  Filme novoFilme = Filme(id, titulo, classificacao);
  catalogo.add(novoFilme);

  print("Filme cadastrado com sucesso!");

  //DELETE
  print("Digite o ID para excluir:");
  int idExcluir = int.parse(stdin.readLineSync()!);

  catalogo.removeWhere((c) => c.id == idExcluir);

  print("Remoção concluída!");

  //UPDATE
  salvarCatalogo(catalogo);
}

void salvarCatalogo(List<Conteudo> catalogo) {
  final file = File('dados.json');

  List listaJson = catalogo.map((c) => c.toJson()).toList();

  file.writeAsStringSync(jsonEncode(listaJson));
}