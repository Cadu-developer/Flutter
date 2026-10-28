import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/missao.dart';
import '../providers/missao_provider.dart';

class DetalhesPage extends StatelessWidget {
  final Missao missao;

  const DetalhesPage({super.key, required this.missao});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MissaoProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('DETALHES DA MISSÃO')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Título:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(missao.titulo, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            const Text('Dificuldade:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
                '${provider.estrelasPorDificuldade(missao.dificuldade)} ${missao.dificuldade}'),
            const SizedBox(height: 16),
            const Text('Pontos:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('${missao.pontos}'),
            const SizedBox(height: 16),
            const Text('Data:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(missao.data),
            const SizedBox(height: 16),
            const Text('Status:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(missao.concluida ? 'Concluída' : 'Pendente'),
            const Spacer(),
            if (!missao.concluida)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    int pts = await provider.concluirMissao(missao);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Missão concluída!\nVocê conquistou $pts pontos.')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('CONCLUIR MISSÃO'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}