import 'package:flutter/material.dart';
import '../models/missao.dart';
import '../services/missao_service.dart';

class MissaoProvider with ChangeNotifier {
  final MissaoService _service = MissaoService();
  List<Missao> _missoes = [];
  bool _carregando = false;

  List<Missao> get missoes => _missoes;
  bool get carregando => _carregando;

  // Soma apenas as concluídas
  int get pontosTotal {
    return _missoes
        .where((m) => m.concluida)
        .fold(0, (sum, m) => sum + m.pontos);
  }

  int calcularPontosPorDificuldade(String dificuldade) {
    switch (dificuldade) {
      case 'Médio':
        return 20;
      case 'Difícil':
        return 30;
      case 'Fácil':
      default:
        return 10;
    }
  }

  String estrelasPorDificuldade(String dificuldade) {
    switch (dificuldade) {
      case 'Médio':
        return '⭐⭐';
      case 'Difícil':
        return '⭐⭐⭐';
      case 'Fácil':
      default:
        return '⭐';
    }
  }

  Future<void> carregarMissoes() async {
    _carregando = true;
    notifyListeners();
    try {
      _missoes = await _service.buscarTodas();
    } catch (e) {
      debugPrint("Erro ao carregar: $e");
    }
    _carregando = false;
    notifyListeners();
  }

Future<void> adicionarMissao(
      String titulo, String dificuldade, String data) async {
    final pontos = calcularPontosPorDificuldade(dificuldade);
    final nova = Missao(
      titulo: titulo,
      dificuldade: dificuldade,
      pontos: pontos,
      data: data,
    );
    await _service.adicionar(nova);
    await carregarMissoes();
  }

  Future<int> concluirMissao(Missao missao) async {
    missao.concluida = true;
    await _service.atualizar(missao);
    await carregarMissoes();
    return missao.pontos;
  }
  
  Future<void> excluirMissao(String id) async {
    await _service.excluir(id);
    await carregarMissoes();
  }
}