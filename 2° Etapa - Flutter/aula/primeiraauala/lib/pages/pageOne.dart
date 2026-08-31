import 'package:flutter/material.dart';
import '../widgets/botao.dart';

class TeladDesign extends StatelessWidget {
  var perguntaSelecionada = 0;

  void responder() {
    perguntaSelecionada++;
    print('Pergunta Respondida. Nova posição: $perguntaSelecionada');
  }

  @override
  Widget build(BuildContext context) {
    // Buscando as cores do tema definido no MaterialApp
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perguntas',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 10,
          ),
        ),
        backgroundColor: cores.secondary,
        centerTitle: true,
      ),
      body: Column(
        children: [

          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.pets,
                color: Colors.blue,
                size: 25

              ),
              
              Text('Qual animal é esse?'),

            ]
          // Pergunta fixa

          ),


          // Imagem fixa
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtp80N9SQ201AAWwPu6TRqc7wOJ-0CB8jr8aA-APcIlh0akyufF9IMYXSCIEUkqr72xQuTngCOe_aXWewXyLeMUPwBHoyePbQdcm15VERS&s=10',
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),

          // Botões fixos
          BotaoResposta('Cachorro'),
          BotaoResposta('Capivara'),
          BotaoResposta('Rato'),

          const SizedBox(height: 50),
        ],
      ),
    );
  }
}