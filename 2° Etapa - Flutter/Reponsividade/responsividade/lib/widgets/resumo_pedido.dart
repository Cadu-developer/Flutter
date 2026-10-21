import 'package:flutter/material.dart';

class ResumoPedido extends StatelessWidget {
  const ResumoPedido({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo.shade50,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Resumo do pedido',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Notebook Pro'),
              subtitle: Text('1 unidade'),
              trailing: Text('R\$ 3.499'),
            ),
            const ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Mouse Gamer'),
              subtitle: Text('1 unidade'),
              trailing: Text('R\$ 129'),
            ),
            const Divider(),
            const Text(
              'Total: R\$ 3.628',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.payment),
              label: const Text('Finalizar compra'),
            ),
          ],
        ),
      ),
    );
  }
}
