import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:apiapi/universidade.dart';


Future<List<dynamic>> buscarUniversidades(String termoBusca) async {

  final url = Uri.parse(
    'http://universities.hipolabs.com/search?name=$termoBusca&country=Brazil',
  );

  final resposta = await http.get(url);

  if (resposta.statusCode == 200) {
    return jsonDecode(resposta.body);
  } else {
    throw Exception('Erro no servidor: Código ${resposta.statusCode}');
  }
}


Future<void> main() async {
  print('=== PORTAL DE UNIVERSIDADES ===\n');

  stdout.write('Digite o nome (ou parte do nome) da universidade: ');
  String pesquisa = stdin.readLineSync()!;

  print('\nBuscando "$pesquisa" nos servidores... ☁️\n');

  List<Universidade> faculdadesEncontradas = [];

  try {
    List<dynamic> listaDaInternet = await buscarUniversidades(pesquisa);

    for (var item in listaDaInternet) {
      String nome = item['name'];
      String pais = item['country'];
      String sigla = item['alpha_two_code'] ?? 'N/A';

      Universidade novaUni = Universidade(nome, pais, sigla);
      faculdadesEncontradas.add(novaUni);
    }

    if (faculdadesEncontradas.isEmpty) {
      print('❌ Nenhuma universidade encontrada contendo "$pesquisa".');
    } else {
      print(
        '✅ Foram encontrados ${faculdadesEncontradas.length} resultados:\n',
      );

      for (var uni in faculdadesEncontradas) {
        uni.exibirDetalhes();
      }
    }
  } catch (e) {
    print('⚠️ Falha ao carregar os dados: $e');
  }

  print('\nSistema finalizado.');
}