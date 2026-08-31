import 'package:flutter/material.dart';
import '../models/cidade_clima.dart';

class CidadeCard extends StatelessWidget {
  final CidadeClima cidade;

  const CidadeCard({super.key, required this.cidade});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Image.network(
              cidade.imagem,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),

            Text(
              cidade.nome,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text("${cidade.temperatura}°C"),

            Text(cidade.condicao),

            const SizedBox(height: 10),

            Text(
              cidade.icone,
              style: const TextStyle(fontSize: 30),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () {},
              child: const Text("Ver detalhes"),
            )
          ],
        ),
      ),
    );
  }
}