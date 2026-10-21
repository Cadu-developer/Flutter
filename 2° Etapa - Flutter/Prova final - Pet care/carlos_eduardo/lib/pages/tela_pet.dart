import 'package:flutter/material.dart';
import 'tela_cadastro_responsavel.dart';

class Pet extends StatefulWidget {
  const Pet({super.key});

  @override
  State<Pet> createState() => _TelaPetState();
}

class _TelaPetState extends State<Pet> {
  final TextEditingController _nomeController = TextEditingController();
  int alimentar = 50;
  int energia = 50;

     void diminuirFome() {
    if (alimentar > 0) {
      setState(() {
        alimentar -= 10;
      });
    }
  }

  void diminuirEnergia() {
    if (energia > 0) {
      setState(() {
        energia -= 10;
      });
    }
  }

  // String get _situacao {
  //   if (_nivelAgua <= 30) {
  //     return 'A planta precisa de água.';
  //   }

  //    else if (_nivelAgua <= 70) {
  //     return 'A planta está bem cuidada.';
  //   } 

  //   else {
  //     return 'Cuidado com o excesso de água.';
  //   }
  // }

  // Color get _corPainel {
  //   if (_nivelAgua <= 30) {
  //     return Colors.amber.shade200;
  //   } 

  //   else if (_nivelAgua <= 70) {
  //     return Colors.green.shade200;
  //   }
    
  //   else {
  //     return Colors.red.shade200;
  //   }
  // }

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
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Icon(Icons.local_florist, size: 60, color: Colors.green),
                const SizedBox(height: 10),
                Text(
                  'Nível de alimentação : $alimentar%',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                 Text(
                  'Nível de energia : $energia%',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );

          Widget botoesControle = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: diminuirFome,
                icon: const Icon(Icons.remove),
                label: const Text(''),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: diminuirEnergia,
                icon: const Icon(Icons.add),
                label: const Text(''),
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
                    labelText: 'Nome do Pet',
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
                          ],
                        ),
                      ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TelaCadastro(),
                      ),
                    );
                  },
                  child: Text('Cadastrar-se'),
                ), 
                    ],
                    
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}