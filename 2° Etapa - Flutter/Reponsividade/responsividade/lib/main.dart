import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'pages/tela_responsiva.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const AppResponsivo(),
    ),
  );
}

class AppResponsivo extends StatelessWidget {
  const AppResponsivo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsividade',
      locale: DevicePreview.locale(context), 
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const TelaResponsiva(),
    );
  }
}
