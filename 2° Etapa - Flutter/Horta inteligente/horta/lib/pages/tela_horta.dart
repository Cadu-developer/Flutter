import 'package:flutter/material.dart';
import 'tela_relatorio.dart';

class TelaHorta extends StatefulWidget {
  const TelaHorta({super.key});

  @override
  State<TelaHorta> createState() => _TelaHortaState();
}

class _TelaHortaState extends State<TelaHorta> {
  final TextEditingController _nomeController = TextEditingController();
  int _nivelAgua = 50;

  void _aumentarAgua() {
    if (_nivelAgua < 100) {
      setState(() {
        _nivelAgua += 10;
      });
    }
  }

  void _diminuirAgua() {
    if (_nivelAgua > 0) {
      setState(() {
        _nivelAgua -= 10;
      });
    }
  }

  String get _situacao {
    if (_nivelAgua <= 30) {
      return 'A planta precisa de água.';
    }

     else if (_nivelAgua <= 70) {
      return 'A planta está bem cuidada.';
    } 

    else {
      return 'Cuidado com o excesso de água.';
    }
  }

  Color get _corPainel {
    if (_nivelAgua <= 30) {
      return Colors.amber.shade200;
    } 

    else if (_nivelAgua <= 70) {
      return Colors.green.shade200;
    }
    
    else {
      return Colors.red.shade200;
    }
  }

  void _exibirCuidados() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Orientações de Cuidados',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              ListTile(
                leading: Icon(Icons.wb_sunny, color: Colors.orange),
                title: Text('Não deixar a planta sem luz'),
              ),
              ListTile(
                leading: Icon(Icons.water_drop, color: Colors.blue),
                title: Text('Evitar excesso de água'),
              ),
              ListTile(
                leading: Icon(Icons.eco, color: Colors.green),
                title: Text('Verificar a terra diariamente'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _irParaRelatorio() {
    if (_nomeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe o nome da planta.')),
      );
    }
    
    else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TelaRelatorio(
            nomePlanta: _nomeController.text.trim(),
            nivelAgua: _nivelAgua,
            situacao: _situacao,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horta Inteligente'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool eTelaLarga = constraints.maxWidth > 600;

          Widget painelStatus = AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _corPainel,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Icon(Icons.local_florist, size: 60, color: Colors.green),
                const SizedBox(height: 10),
                Text(
                  'Nível de Água: $_nivelAgua%',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  _situacao,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );

          Widget botoesControle = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _diminuirAgua,
                icon: const Icon(Icons.remove),
                label: const Text('Diminuir (-10%)'),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: _aumentarAgua,
                icon: const Icon(Icons.add),
                label: const Text('Aumentar (+10%)'),
              ),
            ],
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome da Planta',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.grass),
                  ),
                ),
                const SizedBox(height: 20),
                if (eTelaLarga)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: painelStatus),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          children: [
                            botoesControle,
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _exibirCuidados,
                              child: const Text('Ver cuidados'),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: _irParaRelatorio,
                              child: const Text('Ver relatório'),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                else ...[
                  painelStatus,
                  const SizedBox(height: 20),
                  botoesControle,
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _exibirCuidados,
                    child: const Text('Ver cuidados'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _irParaRelatorio,
                    child: const Text('Ver relatório'),
                  ),
                ]
              ],
            ),
          );
        },
      ),
    );
  }
}