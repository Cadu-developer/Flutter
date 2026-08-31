import 'package:flutter/material.dart';
import './pages/tela_login.dart';
import 'package:device_preview/device_preview.dart';

void main() { //inicio do programa
  runApp(
    DevicePreview( // consegui visualizae o celular
      builder: (context) => MeuApp(),
    ), // DevicePreview
  );
}

class MeuApp extends StatelessWidget { //tipo estático
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) { //mostra na tela oque estamos fazendo
    return MaterialApp( //Configura o aplicativo
      debugShowCheckedModeBanner: false,

      theme: ThemeData( //Tema geral
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          secondary: Colors.amber,
        ), // ColorScheme.fromSeed
      ), // ThemeData

      home: const TelaLogin(), //Primeira tela do app
    ); // MaterialApp
  }
}