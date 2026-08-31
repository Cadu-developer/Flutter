import 'package:flutter/material.dart';

class TelaAstronauta extends StatelessWidget {
  final String nomeAstronauta;
  final String planetaDestino;
  final int energia;
  final String tipoMissao;

  const TelaAstronauta({
    super.key,
    required this.nomeAstronauta,
    required this.planetaDestino,
    required this.energia,
    required this.tipoMissao,
  });

  Map<String, dynamic> _getPropriedadesMissao() {
    switch (tipoMissao) {
      case 'Resgate':
        return {'cor': Colors.orangeAccent, 'icone': Icons.health_and_safety};
      case 'Pesquisa Científica':
        return {'cor': Colors.blueAccent, 'icone': Icons.science};
      case 'Exploração':
      default:
        return {'cor': Colors.greenAccent, 'icone': Icons.explore};
    }
  }

  Map<String, dynamic> _getSituacao() {
    if (energia >= 70) {
      return {
        'texto': 'Missão pronta para iniciar',
        'cor': Colors.green,
      };
    } else if (energia >= 40) {
      return {
        'texto': 'Missão precisa de preparação',
        'cor': Colors.orange,
      };
    } else {
      return {
        'texto': 'Energia insuficiente para a missão',
        'cor': Colors.red,
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final situacao = _getSituacao();
    final detalhesMissao = _getPropriedadesMissao();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ficha do Astronauta'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.deepPurpleAccent,
              child: Icon(
                Icons.person_pin,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              color: const Color(0xFF1E1E2C),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person, color: Colors.cyanAccent),
                      title: const Text('Astronauta'),
                      subtitle: Text(
                        nomeAstronauta,
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.public, color: Colors.cyanAccent),
                      title: const Text('Destino'),
                      subtitle: Text(
                        planetaDestino,
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: Icon(
                        detalhesMissao['icone'] as IconData,
                        color: detalhesMissao['cor'] as Color,
                      ),
                      title: const Text('Tipo de Missão'),
                      subtitle: Text(
                        tipoMissao,
                        style: TextStyle(
                          fontSize: 18,
                          color: detalhesMissao['cor'] as Color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.battery_charging_full, color: Colors.cyanAccent),
                      title: const Text('Energia Atual'),
                      subtitle: Text(
                        '$energia%',
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: (situacao['cor'] as Color).withOpacity(0.2),
                border: Border.all(color: situacao['cor'] as Color, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                situacao['texto'] as String,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: situacao['cor'] as Color,
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Voltar'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}