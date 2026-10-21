import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/voo.dart';
import 'detalhes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _aeroportoController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    final provider = Provider.of<VooProvider>(
      context,
      listen: false,
    );

    _aeroportoController.text = provider.aeroporto;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.buscarVoos();
    });
  }

  @override
  void dispose() {
    _aeroportoController.dispose();
    super.dispose();
  }

  void _buscar() {
    final aeroporto = _aeroportoController.text.trim();

    if (aeroporto.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Digite um código ICAO com 4 caracteres.',
          ),
        ),
      );

      return;
    }

    Provider.of<VooProvider>(
      context,
      listen: false,
    ).buscarVoos(
      aeroporto: aeroporto,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de Voos'),
        centerTitle: true,
      ),
      body: Consumer<VooProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              _filtros(provider),

              const Divider(height: 1),

              Expanded(
                child: _conteudo(provider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _filtros(VooProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _aeroportoController,
            textCapitalization: TextCapitalization.characters,
            maxLength: 4,
            decoration: InputDecoration(
              labelText: 'Código ICAO',
              hintText: 'Ex.: SBGR',
              prefixIcon: const Icon(Icons.local_airport),
              suffixIcon: IconButton(
                onPressed: _buscar,
                icon: const Icon(Icons.search),
              ),
              border: const OutlineInputBorder(),
              counterText: '',
            ),
            onSubmitted: (_) => _buscar(),
          ),

          const SizedBox(height: 12),

          DropdownButtonFormField<String>(
            value: provider.tipo,
            decoration: const InputDecoration(
              labelText: 'Tipo de voo',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                value: 'chegadas',
                child: Text('Chegadas'),
              ),
              DropdownMenuItem(
                value: 'partidas',
                child: Text('Partidas'),
              ),
              DropdownMenuItem(
                value: 'todos',
                child: Text('Todos'),
              ),
            ],
            onChanged: (valor) {
              if (valor == null) return;

              provider.buscarVoos(
                tipo: valor,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _conteudo(VooProvider provider) {
    if (provider.carregando) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (provider.erro != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 60,
                color: Colors.red,
              ),

              const SizedBox(height: 16),

              Text(
                provider.erro!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 16),

              ElevatedButton.icon(
                onPressed: () {
                  provider.buscarVoos();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      );
    }

    if (provider.voos.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.flight_takeoff,
              size: 60,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'Nenhum voo encontrado.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => provider.buscarVoos(),
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: provider.voos.length,
        itemBuilder: (context, index) {
          final voo = provider.voos[index];

          return _cardVoo(context, voo);
        },
      ),
    );
  }

  Widget _cardVoo(
    BuildContext context,
    Map<String, dynamic> voo,
  ) {
    final identificacao =
        voo['voo'] ??
        voo['numero_voo'] ??
        voo['flight'] ??
        'Voo não informado';

    final origem =
        voo['origem'] ??
        voo['origin'] ??
        'Não informado';

    final destino =
        voo['destino'] ??
        voo['destination'] ??
        'Não informado';

    final horario =
        voo['horario'] ??
        voo['hora'] ??
        voo['schedule'] ??
        'Não informado';

    final status =
        voo['status'] ??
        'Não informado';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),

        leading: const CircleAvatar(
          radius: 25,
          child: Icon(Icons.flight),
        ),

        title: Text(
          identificacao.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$origem → $destino',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 5),

              Text('Horário: $horario'),

              Text('Status: $status'),
            ],
          ),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
        ),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetalhesPage(
                voo: voo,
              ),
            ),
          );
        },
      ),
    );
  }
}