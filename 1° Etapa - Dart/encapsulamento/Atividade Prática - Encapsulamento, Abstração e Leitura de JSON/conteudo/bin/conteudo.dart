import 'dart:io';
import 'dart:convert';
import '../lib/conteudo.dart';

void main() {
  String texto = File('dados.json').readAsStringSync();
  var dados = jsonDecode(texto);

  Filme filme = Filme(dados['titulo']);

  try {
    filme.validarClassificacao = dados['classificacao'];
  } catch (e) {
    print(e);
  }
}
