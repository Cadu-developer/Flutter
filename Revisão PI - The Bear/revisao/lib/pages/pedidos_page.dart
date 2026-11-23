import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/pedido_viewmodel.dart';

class PedidosPage extends StatefulWidget {
  const PedidosPage({super.key});

  @override
  State<PedidosPage> createState() =>
      _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  final clienteController = TextEditingController();
  final pratoController = TextEditingController();
  final quantidadeController = TextEditingController();
  final valorController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<PedidoViewModel>().carregarPedidos();
    });
  }

  void limparCampos() {
    clienteController.clear();
    pratoController.clear();
    quantidadeController.clear();
    valorController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PedidoViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos - The Bear'),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: clienteController,
                  decoration: const InputDecoration(
                    labelText: 'Cliente',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: pratoController,
                  decoration: const InputDecoration(
                    labelText: 'Prato',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: quantidadeController,
                        keyboardType:
                            TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Quantidade',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: TextField(
                        controller: valorController,
                        keyboardType:
                            const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Valor unitário',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final cliente =
                          clienteController.text.trim();

                      final prato =
                          pratoController.text.trim();

                      final quantidade = int.tryParse(
                        quantidadeController.text,
                      );

                      final valor = double.tryParse(
                        valorController.text
                            .replaceAll(',', '.'),
                      );

                      if (cliente.isEmpty ||
                          prato.isEmpty ||
                          quantidade == null ||
                          valor == null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Preencha todos os campos.',
                            ),
                          ),
                        );

                        return;
                      }

                      await context
                          .read<PedidoViewModel>()
                          .adicionarPedido(
                            cliente: cliente,
                            prato: prato,
                            quantidade: quantidade,
                            valorUnitario: valor,
                          );

                      limparCampos();
                    },
                    child: const Text(
                      'CADASTRAR PEDIDO',
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(),

          Expanded(
            child: viewModel.carregando
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : viewModel.pedidos.isEmpty
                    ? const Center(
                        child: Text(
                          'Nenhum pedido cadastrado.',
                        ),
                      )
                    : ListView.builder(
                        itemCount:
                            viewModel.pedidos.length,
                        itemBuilder:
                            (context, index) {
                          final pedido =
                              viewModel.pedidos[index];

                          return Card(
                            margin:
                                const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${pedido.cliente} | ${pedido.prato}',
                                    style:
                                        const TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 8,
                                  ),

                                  Text(
                                    'Quantidade: ${pedido.quantidade}',
                                  ),

                                  Text(
                                    'Total: R\$ ${pedido.total.toStringAsFixed(2).replaceAll('.', ',')}',
                                  ),

                                  Text(
                                    'Classificação: ${pedido.classificacao}',
                                  ),

                                  Text(
                                    'Status: ${pedido.status}',
                                    style: TextStyle(
                                      fontWeight:
                                          FontWeight.bold,
                                      color: pedido.status ==
                                              'Finalizado'
                                          ? Colors.green
                                          : Colors.orange,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  Row(
                                    children: [
                                      if (pedido.status ==
                                          'Pendente')
                                        ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<
                                                    PedidoViewModel>()
                                                .finalizarPedido(
                                                  pedido.id!,
                                                );
                                          },
                                          child:
                                              const Text(
                                            'FINALIZAR',
                                          ),
                                        ),

                                      const SizedBox(
                                        width: 10,
                                      ),

                                      ElevatedButton(
                                        style:
                                            ElevatedButton
                                                .styleFrom(
                                          backgroundColor:
                                              Colors.red,
                                          foregroundColor:
                                              Colors.white,
                                        ),
                                        onPressed: () {
                                          context
                                              .read<
                                                  PedidoViewModel>()
                                              .excluirPedido(
                                                pedido.id!,
                                              );
                                        },
                                        child:
                                            const Text(
                                          'EXCLUIR',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}