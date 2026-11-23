import 'package:flutter/material.dart';
import '../models/pedido.dart';
import '../services/banco_service.dart';

class PedidoViewModel extends ChangeNotifier {
  final BancoService bancoService;

  PedidoViewModel({
    required this.bancoService,
  });

  List<Pedido> pedidos = [];

  bool carregando = false;

  Future<void> carregarPedidos() async {
    carregando = true;
    notifyListeners();

    pedidos = await bancoService.listarPedidos();

    carregando = false;
    notifyListeners();
  }

  Future<void> adicionarPedido({
    required String cliente,
    required String prato,
    required int quantidade,
    required double valorUnitario,
  }) async {
    // Cálculo automático
    final total = quantidade * valorUnitario;

    // Classificação automática
    final classificacao =
        quantidade >= 5
            ? 'PEDIDO GRANDE'
            : 'PEDIDO NORMAL';

    final pedido = Pedido(
      cliente: cliente,
      prato: prato,
      quantidade: quantidade,
      valorUnitario: valorUnitario,
      total: total,
      classificacao: classificacao,
      status: 'Pendente',
    );

    await bancoService.inserirPedido(pedido);

    await carregarPedidos();
  }

  Future<void> finalizarPedido(int id) async {
    await bancoService.finalizarPedido(id);

    await carregarPedidos();
  }

  Future<void> excluirPedido(int id) async {
    await bancoService.excluirPedido(id);

    await carregarPedidos();
  }
}