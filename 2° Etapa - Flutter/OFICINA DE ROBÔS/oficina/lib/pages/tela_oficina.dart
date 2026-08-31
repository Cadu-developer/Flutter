import 'package:flutter/material.dart';
import '../widgets/cartao_peca.dart';
import 'tela_diagnostico.dart';

class TelaOficina extends StatefulWidget {
  const TelaOficina({super.key});

  @override
  State<TelaOficina> createState() => _TelaOficinaState();
}

class _TelaOficinaState extends State<TelaOficina> {
  final _nomeController = TextEditingController();

  double _energia = 30.0;
  bool _cabecaInstalada = false;
  bool _bracoInstalado = false;
  bool _sensorInstalado = false;

  String _resultadoTeste = '';
  double _opacidadeResultado = 0.0;

  void _adicionarEnergia() {
    setState(() {
      if (_energia < 100.0) {
        _energia = (_energia + 10.0).clamp(0.0, 100.0);
      }
    });
  }

  void _removerEnergia() {
    setState(() {
      if (_energia > 0.0) {
        _energia = (_energia - 10.0).clamp(0.0, 100.0);
      }
    });
  }

  Color _obterCorPainel() {
    if (_energia < 50.0) {
      return Colors.red.shade400;
    } else if (_energia <= 70.0) {
      return Colors.orange.shade400;
    } else {
      return Colors.green.shade400;
    }
  }

  int _obterQuantidadePecasInstaladas() {
    int qtd = 0;
    if (_cabecaInstalada) qtd++;
    if (_bracoInstalado) qtd++;
    if (_sensorInstalado) qtd++;
    return qtd;
  }

  void _testarRobo() {
    FocusScope.of(context).unfocus();

    if (_nomeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe o nome do robô.')),
      );
      return;
    }

    if (_energia < 50.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Energia insuficiente para realizar o teste.')),
      );
      return;
    }

    if (_obterQuantidadePecasInstaladas() < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Instale pelo menos duas peças.')),
      );
      return;
    }

    setState(() {
      _resultadoTeste = 'Teste realizado com sucesso!';
      _opacidadeResultado = 1.0;
    });
  }

  void _abrirDiagnostico() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaDiagnostico(
          nomeRobo: _nomeController.text.trim().isEmpty
              ? 'Não informado'
              : _nomeController.text.trim(),
          energia: _energia,
          pecasInstaladas: _obterQuantidadePecasInstaladas(),
          resultadoTeste: _resultadoTeste.isEmpty ? 'Nenhum teste realizado' : _resultadoTeste,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oficina de Robôs'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool telaLarga = constraints.maxWidth > 600;

          List<Widget> cartoesPecas = [
            CartaoPeca(
              icone: Icons.smart_toy,
              nome: 'Cabeça',
              instalada: _cabecaInstalada,
              aoApertarBotao: () => setState(() => _cabecaInstalada = !_cabecaInstalada),
            ),
            CartaoPeca(
              icone: Icons.precision_manufacturing,
              nome: 'Braço mecânico',
              instalada: _bracoInstalado,
              aoApertarBotao: () => setState(() => _bracoInstalado = !_bracoInstalado),
            ),
            CartaoPeca(
              icone: Icons.sensors,
              nome: 'Sensor',
              instalada: _sensorInstalado,
              aoApertarBotao: () => setState(() => _sensorInstalado = !_sensorInstalado),
            ),
          ];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do Robô',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Icon(Icons.android, size: 80, color: Colors.blue),
                ),
                const SizedBox(height: 16),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: _obterCorPainel(),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Nível de Energia: ${_energia.toInt()}%',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _adicionarEnergia,
                            child: const Text('+10%'),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: _removerEnergia,
                            child: const Text('-10%'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Peças do Robô',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                if (telaLarga)
                  Row(
                    children: cartoesPecas
                        .map((cartao) => Expanded(child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: cartao,
                            )))
                        .toList(),
                  )
                else
                  Column(
                    children: cartoesPecas
                        .map((cartao) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: cartao,
                            ))
                        .toList(),
                  ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _testarRobo,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Testar robô', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 12),
                AnimatedOpacity(
                  opacity: _opacidadeResultado,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green),
                    ),
                    child: Text(
                      _resultadoTeste,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: _abrirDiagnostico,
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(16)),
                  child: const Text('Abrir diagnóstico', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}