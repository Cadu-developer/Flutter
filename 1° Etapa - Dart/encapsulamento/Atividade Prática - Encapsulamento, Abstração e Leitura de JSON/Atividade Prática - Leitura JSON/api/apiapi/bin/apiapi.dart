import 'dart:convert';
import 'package:http/http.dart' as http;


Future<List<dynamic>> buscarRacasDeCachorro() async {
  final url = Uri.parse('https://dogapi.dog/api/v2/breeds');

  final resposta = await http.get(url);

  if (resposta.statusCode == 200) {
    Map<String, dynamic> corpoDaResposta = jsonDecode(resposta.body);

    return corpoDaResposta['data'];
  } else {
    throw Exception('Erro no servidor: Código ${resposta.statusCode}');
  }
}

Future<void> main() async {
  print('1. Iniciando o sistema...');
  print('2. Solicitando dados ao servidor... 🐶');

  try {
    List<dynamic> listaDeRacas = await buscarRacasDeCachorro();

    print('\n3. Resposta recebida com sucesso! \n');
    print('=== LISTA DE RAÇAS DE CACHORRO ===');

    for (var raca in listaDeRacas) {
      String nome = raca['attributes']['name'];
      int expectativaVidaMax = raca['attributes']['life']['max'];

      print('Raça: $nome | Expectativa máxima: $expectativaVidaMax anos');
    }
  } catch (e) {
    print('\n⚠️ Falha na requisição: $e');
  }

  print('\n4. Fim do programa.');
}