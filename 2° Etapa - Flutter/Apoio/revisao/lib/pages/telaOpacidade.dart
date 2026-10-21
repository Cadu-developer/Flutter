import 'package:flutter/material.dart';

class TelaAnimatedOpacity extends StatefulWidget {
  const TelaAnimatedOpacity({super.key});

  @override
  State<TelaAnimatedOpacity> createState() {
    return _TelaAnimatedOpacityState();
  }
}

class _TelaAnimatedOpacityState extends State<TelaAnimatedOpacity> {
  bool visivel = false;//varial booleana que vai mudar o estado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedOpacity'),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.visibility,
                size: 80,
                color: Colors.blue,
              ),

              const SizedBox(height: 20),

              const Text(
                'AnimatedOpacity',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Esse widget faz algo aparecer ou desaparecer suavemente.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              AnimatedOpacity(
                opacity: visivel ? 1.0 : 0.0,//Anima a visibilidade do widget
                duration: const Duration(seconds: 1),// duração da animação
                child: Container(//container ou componente que vai mudar a opacidade
                  width: 260,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Este texto aparece e desaparece com animação.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton.icon(//bota que muda o estado
                onPressed: () {
                  setState(() {
                    visivel = !visivel;
                  });
                },
                icon: const Icon(Icons.visibility),
                label: const Text('Mostrar / Esconder'),
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}