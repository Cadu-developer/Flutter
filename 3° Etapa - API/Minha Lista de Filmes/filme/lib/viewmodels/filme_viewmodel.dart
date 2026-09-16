import 'package:flutter/foundation.dart';
import '../models/filme.dart';
import '../services/filme_service.dart';

class FilmeViewModel extends ChangeNotifier {
  final FilmeService _filmeService = FilmeService();
  List<Filme> _filmes = [];

  List<Filme> get filmes => _filmes;

  // Carrega os filmes do banco e notifica a interface
  Future<void> carregarFilmes() async {
    _filmes = await _filmeService.listarFilmes();
    notifyListeners();
  }

  // Adiciona um novo filme
  Future<void> adicionarFilme(String titulo) async {
    if (titulo.trim().isEmpty) return;
    final novoFilme = Filme(titulo: titulo, assistido: false);
    await _filmeService.inserirFilme(novoFilme);
    await carregarFilmes();
  }

  // Altera o status (assistido/não assistido)
  Future<void> alterarStatus(Filme filme, bool assistido) async {
    final filmeAtualizado = filme.copyWith(assistido: assistido);
    await _filmeService.atualizarFilme(filmeAtualizado);
    await carregarFilmes();
  }
}