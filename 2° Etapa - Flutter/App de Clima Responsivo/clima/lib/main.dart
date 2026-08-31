import 'package:flutter/material.dart';
import 'pages/tela_clima.dart';
import 'package:device_preview/device_preview.dart';

void main() { //inicio do programa
  runApp(
    DevicePreview( // consegui visualizae o celular
      builder: (context) => ClimaAgora(),
    ), // DevicePreview
  );
}

class ClimaAgora extends StatelessWidget {
  const ClimaAgora({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clima Agora',
      home: TelaClima(),
    );
  }
}