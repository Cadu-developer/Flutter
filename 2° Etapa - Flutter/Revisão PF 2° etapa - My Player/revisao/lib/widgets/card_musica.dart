import 'package:flutter/material.dart';

class CardMusica extends StatelessWidget {
  final String nome;
  final String artista;
  final bool reproduzindo;

  const CardMusica({
    super.key,
    required this.nome,
    required this.artista,
    required this.reproduzindo,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: reproduzindo ? 290 : 260,
      height: reproduzindo ? 290 : 260,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: reproduzindo ? Colors.deepPurple.shade100 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            reproduzindo ? Icons.music_note : Icons.music_off,
            size: 90,
            color: Colors.deepPurple,
          ),
          const SizedBox(height: 20),
          Text(
            nome,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            artista,
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            reproduzindo ? 'Reproduzindo' : 'Pausado',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: reproduzindo ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
