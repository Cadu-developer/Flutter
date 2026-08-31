import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) => const LanchoneteExpress(),
    ),
  );
}

class LanchoneteExpress extends StatelessWidget {
  const LanchoneteExpress({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: "Lanchonete Express",
      home: const TelaInicial(),
    );
  }
}

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lanchonete Express"),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              const Text(
                "Bem-vindo à Lanchonete Express!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              CardProduto(
                nome: "X-Burguer",
                preco: "R\$ 18,00",
                descricao: "Pão, carne, queijo e molho especial.",
                aoClicar: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TelaDetalhes(
                        nome: "X-Burguer",
                        preco: "R\$ 18,00",
                        descricao: "Pão, carne, queijo e molho especial.",
                      ),
                    ),
                  );
                },
              ),

              CardProduto(
                nome: "Batata Frita",
                preco: "R\$ 12,00",
                descricao: "Porção crocante individual.",
                aoClicar: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TelaDetalhes(
                        nome: "Batata Frita",
                        preco: "R\$ 12,00",
                        descricao: "Porção crocante individual.",
                      ),
                    ),
                  );
                },
              ),

              CardProduto(
                nome: "Suco Natural",
                preco: "R\$ 8,00",
                descricao: "Suco fresco da fruta.",
                aoClicar: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TelaDetalhes(
                        nome: "Suco Natural",
                        preco: "R\$ 8,00",
                        descricao: "Suco fresco da fruta.",
                      ),
                    ),
                  );
                },
              ),

              CardProduto(
                nome: "Combo Especial",
                preco: "R\$ 28,00",
                descricao: "X-Burguer, batata e suco.",
                aoClicar: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TelaDetalhes(
                        nome: "Combo Especial",
                        preco: "R\$ 28,00",
                        descricao: "X-Burguer, batata e suco.",
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TelaPedido(),
                    ),
                  );
                },
                child: const Text("Fazer Pedido"),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Promoção do dia:\n\n"
                          "Na compra de um X-Burguer, o suco sai pela metade do preço!",
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    },
                  );
                },
                child: const Text("Ver promoção"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardProduto extends StatelessWidget {
  final String nome;
  final String preco;
  final String descricao;
  final VoidCallback aoClicar;

  const CardProduto({
    super.key,
    required this.nome,
    required this.preco,
    required this.descricao,
    required this.aoClicar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.fastfood, color: Colors.red, size: 30),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nome,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(preco,
                          style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(descricao),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: aoClicar,
              child: const Text("Ver detalhes"),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaDetalhes extends StatefulWidget {
  final String nome;
  final String preco;
  final String descricao;

  const TelaDetalhes({
    super.key,
    required this.nome,
    required this.preco,
    required this.descricao,
  });

  @override
  State<TelaDetalhes> createState() => _TelaDetalhesState();
}

class _TelaDetalhesState extends State<TelaDetalhes> {
  bool destaque = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Text(widget.nome,
                style: const TextStyle(
                    fontSize: 26, fontWeight: FontWeight.bold)),

            Text(widget.preco,
                style: const TextStyle(
                    fontSize: 20, color: Colors.green)),

            const SizedBox(height: 10),

            Text(widget.descricao),

            const SizedBox(height: 20),

            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: destaque ? 120 : 70,
              decoration: BoxDecoration(
                color: destaque ? Colors.amber : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(destaque ? 25 : 10),
              ),
              child: Center(
                child: Text(
                  destaque
                      ? "⭐ Produto mais pedido da semana!"
                      : "Clique para destacar",
                ),
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  destaque = !destaque;
                });
              },
              child: const Text("Adicionar destaque"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Voltar"),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaPedido extends StatefulWidget {
  const TelaPedido({super.key});

  @override
  State<TelaPedido> createState() => _TelaPedidoState();
}

class _TelaPedidoState extends State<TelaPedido> {
  final nomeController = TextEditingController();
  final produtoController = TextEditingController();
  final obsController = TextEditingController();

  int contador = 0;

  void enviarPedido() {
    if (nomeController.text.isEmpty || produtoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha nome e produto!")),
      );
      return;
    }

    setState(() {
      contador++;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Pedido enviado com sucesso!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedido"),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Text("Pedidos enviados: $contador"),

            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: "Nome"),
            ),

            TextField(
              controller: produtoController,
              decoration: const InputDecoration(labelText: "Produto"),
            ),

            TextField(
              controller: obsController,
              decoration: const InputDecoration(labelText: "Observação"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: enviarPedido,
              child: const Text("Enviar Pedido"),
            ),
          ],
        ),
      ),
    );
  }
}

// 1. Qual é a função do Scaffold em uma tela Flutter?
// O Scaffold fornece a estrutura básica da tela, como AppBar, Body, FloatingActionButton, etc.
//
// 2. Para que serve o AppBar?
// O AppBar é a barra superior da tela onde ficam o título e ações.
//
// 3. Diferença entre StatelessWidget e StatefulWidget:
// StatelessWidget não muda estado.
// StatefulWidget pode mudar estado com setState.
//
// 4. Para que serve o setState?
// Atualiza a interface quando o estado muda.
//
// 5. O que acontece com Navigator.push?
// Abre uma nova tela e coloca na pilha de navegação.
//
// 6. O que acontece com Navigator.pop?
// Fecha a tela atual e volta para a anterior.
//
// 7. Para que serve o TextEditingController?
// Controla e lê o texto dos TextFields.
//
// 8. Por que validar os campos?
// Para evitar envio de dados vazios ou inválidos.
//
// 9. Para que serve o SnackBar?
// Exibe mensagens rápidas na parte inferior da tela.
//
// 10. O que o showModalBottomSheet faz?
// Abre uma janela inferior com informações temporárias.
//
// 11. Para que serve o AnimatedContainer?
// Cria animações automáticas ao mudar propriedades visuais.
//
// 12. Por que usar SingleChildScrollView?
// Evita overflow quando o conteúdo não cabe na tela.
//
// 13. Vantagem do CardProduto:
// Reutilização de código e organização.
//
// 14. Diferença entre Column e ListView:
// Column não rola, ListView permite rolagem.
//
// 15. Por que separar widgets?
// Deixa o código mais organizado e fácil de manter.

