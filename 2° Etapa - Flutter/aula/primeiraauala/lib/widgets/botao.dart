import 'package:flutter/material.dart';


class BotaoResposta extends StatelessWidget {
  final String texto;

  const BotaoResposta(this.texto, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          print('Resposta escolhida: $texto');
        },
        child: Text(texto),
      ),
    );
  }
}