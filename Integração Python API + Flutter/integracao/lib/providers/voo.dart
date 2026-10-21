import 'package:flutter/material.dart';
import '../services/voo.dart';

class VooProvider extends ChangeNotifier {
  final VooService _service = VooService();

  List<Map<String, dynamic>> _voos = [];

  bool _carregando = false;
  String? _erro;
  String _aeroporto = 'SBGR';
  String _tipo = 'chegadas';
  List<Map<String, dynamic>> get voos => _voos;
  bool get carregando => _carregando;
  String? get erro => _erro;
  String get aeroporto => _aeroporto;
  String get tipo => _tipo;

  Future<void> buscarVoos({
    String? aeroporto,
    String? tipo,
  }) async {
    if (aeroporto != null && aeroporto.trim().isNotEmpty) {
      _aeroporto = aeroporto.trim().toUpperCase();
    }

    if (tipo != null) {
      _tipo = tipo;
    }

    _carregando = true;
    _erro = null;

    notifyListeners();

    try {
      _voos = await _service.buscarVoos(
        aeroporto: _aeroporto,
        tipo: _tipo,
      );
    } catch (e) {
      _voos = [];
      _erro = 'Não foi possível carregar os voos.';
    }

    _carregando = false;

    notifyListeners();
  }
}