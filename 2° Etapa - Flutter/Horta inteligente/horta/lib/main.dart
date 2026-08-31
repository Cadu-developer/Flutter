import 'package:flutter/material.dart';
import 'pages/tela_horta.dart';

void main() {
  runApp(const HortaInteligenteApp());
}

class HortaInteligenteApp extends StatelessWidget {
  const HortaInteligenteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horta Inteligente',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const TelaHorta(),
    );
  }
}