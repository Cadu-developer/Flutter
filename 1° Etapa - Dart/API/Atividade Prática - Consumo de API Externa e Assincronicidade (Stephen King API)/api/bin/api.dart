import 'dart:convert';
import 'package:http/http.dart' as http;
import '../lib/api.dart';

Future<List<dynamic>> buscarLivros() async {
  final url = Uri.parse("https://stephen-king-api.onrender.com/api/books");

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final dados = jsonDecode(response.body);


    return dados["data"];
  } else {
    throw Exception("Erro na requisição: ${response.statusCode}");
  }
}

Future<void> main() async {
  List<Livro> catalogo = [];

  try {
    final listaDinamica = await buscarLivros();

    for (var item in listaDinamica) {
      String titulo = item["Title"] ?? "Sem título";
      int paginas = item["Pages"] ?? 0;

      List<String> nomesViloes = [];

      if (item["villains"] != null) {
        for (var vilao in item["villains"]) {
          nomesViloes.add(vilao["name"]);
        }
      }

      Livro livro = Livro(
        titulo: titulo,
        paginas: paginas,
        viloes: nomesViloes,
      );

      catalogo.add(livro);
    }

    for (var livro in catalogo) {
      livro.exibirDetalhes();
    }
  } catch (e) {
    print("❌ Erro ao buscar dados: $e");
  }
}