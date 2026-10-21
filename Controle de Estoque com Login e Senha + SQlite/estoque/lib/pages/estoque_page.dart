import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../providers/produto_provider.dart';

class EstoquePage extends StatefulWidget {
  const EstoquePage({super.key});

  @override
  State<EstoquePage> createState() => _EstoquePageState();
}

class _EstoquePageState extends State<EstoquePage> {
  final provider = ProdutoProvider();

  List<Produto> produtos = [];
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    carregarProdutos();
  }

  Future<void> carregarProdutos() async {
    setState(() => carregando = true);

    final lista = await provider.listar();

    if (!mounted) return;

    setState(() {
      produtos = lista;
      carregando = false;
    });
  }

  Future<void> alterarQuantidade(
    Produto produto,
    int novaQuantidade,
  ) async {
    if (novaQuantidade < 0) return;

    await provider.atualizarQuantidade(
      produto.id!,
      novaQuantidade,
    );

    await carregarProdutos();
  }

  Future<void> excluirProduto(Produto produto) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir produto'),
          content: Text(
            'Deseja excluir "${produto.nome}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('CANCELAR'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('EXCLUIR'),
            ),
          ],
        );
      },
    );

    if (confirmar == true) {
      await provider.excluir(produto.id!);
      await carregarProdutos();
    }
  }

  String formatarPreco(double preco) {
    return 'R\$ ${preco.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estoque'),
        actions: [
          IconButton(
            tooltip: 'Atualizar',
            icon: const Icon(Icons.refresh),
            onPressed: carregarProdutos,
          ),
        ],
      ),
      body: carregando
          ? const Center(child: CircularProgressIndicator())
          : produtos.isEmpty
              ? const Center(
                  child: Text('Nenhum produto cadastrado.'),
                )
              : RefreshIndicator(
                  onRefresh: carregarProdutos,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: produtos.length,
                    itemBuilder: (context, index) {
                      final produto = produtos[index];
                      final estoqueBaixo = produto.quantidade <= 3;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      produto.nome,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    tooltip: 'Excluir',
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                    onPressed: () =>
                                        excluirProduto(produto),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text('Categoria: ${produto.categoria}'),
                              const SizedBox(height: 6),
                              Text(
                                'Preço: ${formatarPreco(produto.preco)}',
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Text(
                                    'Quantidade: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: produto.quantidade > 0
                                        ? () => alterarQuantidade(
                                              produto,
                                              produto.quantidade - 1,
                                            )
                                        : null,
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                    ),
                                  ),
                                  Text(
                                    '${produto.quantidade}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => alterarQuantidade(
                                      produto,
                                      produto.quantidade + 1,
                                    ),
                                    icon: const Icon(
                                      Icons.add_circle_outline,
                                    ),
                                  ),
                                ],
                              ),
                              if (estoqueBaixo)
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade100,
                                    borderRadius:
                                        BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'ESTOQUE BAIXO',
                                    style: TextStyle(
                                      color: Colors.red.shade900,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}