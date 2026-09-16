import 'dart:convert';
import 'package:http/http.dart' as http;

class VooService {
  static const String baseUrl = 'http://127.0.0.1:5001/api/voos';

  Future<List<Map<String, dynamic>>> buscarVoos({
    required String aeroporto,
    required String tipo,
  }) async {
    final uri = Uri.parse(baseUrl).replace(
      queryParameters: {
        'aeroporto': aeroporto,
        'tipo': tipo,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        'Erro ao consultar a API. Código: ${response.statusCode}',
      );
    }

    final dynamic dados = jsonDecode(response.body);

    if (dados is List) {
      return dados
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }

    if (dados is Map && dados['voos'] is List) {
      return (dados['voos'] as List)
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }

    throw Exception('Formato de resposta da API não reconhecido.');
  }
}