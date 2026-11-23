import 'package:flutter/material.dart';

class DetalhesPage extends StatelessWidget {
  final Map<String, dynamic> voo;

  const DetalhesPage({
    super.key,
    required this.voo,
  });

  String valor(String chave) {
    final value = voo[chave];

    if (value == null || value.toString().isEmpty) {
      return 'Não informado';
    }

    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do voo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(
                    Icons.flight,
                    size: 60,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    valor('voo'),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  _informacao(
                    'Origem',
                    valor('origem'),
                    Icons.flight_takeoff,
                  ),

                  _informacao(
                    'Destino',
                    valor('destino'),
                    Icons.flight_land,
                  ),

                  _informacao(
                    'Horário',
                    valor('horario'),
                    Icons.access_time,
                  ),

                  _informacao(
                    'Status',
                    valor('status'),
                    Icons.info_outline,
                  ),

                  _informacao(
                    'Companhia',
                    valor('companhia'),
                    Icons.business,
                  ),

                  _informacao(
                    'Tipo',
                    valor('tipo'),
                    Icons.flight_class,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Todas as informações recebidas da API',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          ...voo.entries.map(
            (entry) => ListTile(
              title: Text(entry.key),
              subtitle: Text(entry.value?.toString() ?? 'Não informado'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _informacao(
    String titulo,
    String valor,
    IconData icone,
  ) {
    return ListTile(
      leading: Icon(icone, color: Colors.blue),
      title: Text(
        titulo,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(valor),
    );
  }
}