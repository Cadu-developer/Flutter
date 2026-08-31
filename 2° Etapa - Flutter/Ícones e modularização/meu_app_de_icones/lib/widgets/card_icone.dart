import 'package:flutter/material.dart';

class CardIcone extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String descricao;
  final String textoBotao;
  final Color cor;
  final VoidCallback onPressed;

  const CardIcone({
    super.key,
    required this.icone,
    required this.titulo,
    required this.descricao,
    required this.textoBotao,
    required this.cor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: cor,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icone,
            color: cor,
            size: 50,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: cor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  descricao,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cor,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(textoBotao),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
