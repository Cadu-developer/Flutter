import 'package:flutter/material.dart';
import 'package:desafio/pages/tela_login.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({super.key});

  @override
  State<TelaHome> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.home,
                size: 80,
                color: Colors.blue,
              ),

              const SizedBox(height: 10),

              const Text(
                'Bem-vindo!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Login realizado com sucesso!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TelaLogin(),
                    ),
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text('Sair'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}