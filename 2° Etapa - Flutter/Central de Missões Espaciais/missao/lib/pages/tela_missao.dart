import 'package:flutter/material.dart';
import '../widgets/card_missao.dart';
import 'tela_astronauta.dart';

class TelaMissao extends StatefulWidget {
  const TelaMissao({super.key});

  @override
  State<TelaMissao> createState() => _TelaMissaoState();
}

class _TelaMissaoState extends State<TelaMissao> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _planetaController = TextEditingController();

  int _energia = 50;
  String _tipoMissao = 'Exploração';
  final List<String> _tiposMissao = [
    'Exploração',
    'Resgate',
    'Pesquisa Científica',
  ];

  @override
  void dispose() {
    _nomeController.dispose();
    _planetaController.dispose();
    super.dispose();
  }

  void _aumentarEnergia() {
    setState(() {
      if (_energia < 100) {
        _energia = (_energia + 10).clamp(0, 100);
      }
    });
  }

  void _diminuirEnergia() {
    setState(() {
      if (_energia > 0) {
        _energia = (_energia - 10).clamp(0, 100);
      }
    });
  }

  void _visualizarMissao() {
    final nome = _nomeController.text.trim();
    final planeta = _planetaController.text.trim();

    if (nome.isEmpty || planeta.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos obrigatórios!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaAstronauta(
          nomeAstronauta: nome,
          planetaDestino: planeta,
          energia: _energia,
          tipoMissao: _tipoMissao,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Central de Missões'),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.rocket, color: Colors.cyanAccent),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do Astronauta',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _planetaController,
              decoration: const InputDecoration(
                labelText: 'Planeta de Destino',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.public),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tipo de Missão:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _tipoMissao,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: _tiposMissao.map((tipo) {
                return DropdownMenuItem(
                  value: tipo,
                  child: Text(tipo),
                );
              }).toList(),
              onChanged: (novoValor) {
                if (novoValor != null) {
                  setState(() {
                    _tipoMissao = novoValor;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2C),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Energia Atual: $_energia%',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyanAccent,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _diminuirEnergia,
                        icon: const Icon(Icons.remove),
                        label: const Text('Diminuir'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _aumentarEnergia,
                        icon: const Icon(Icons.add),
                        label: const Text('Aumentar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Etapas da Missão',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const CardMissao(
              icone: Icons.build_circle,
              titulo: 'Preparação da nave',
              descricao: 'Verifique todos os equipamentos e sistemas da nave.',
            ),
            const CardMissao(
              icone: Icons.flight_takeoff,
              titulo: 'Viagem espacial',
              descricao: 'Monitore as rotas orbitais e o suporte de vida.',
            ),
            const CardMissao(
              icone: Icons.explore,
              titulo: 'Exploração do planeta',
              descricao: 'Colete amostras e faça o mapeamento do terreno.',
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _visualizarMissao,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.deepPurpleAccent,
              ),
              child: const Text(
                'Visualizar Missão',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}