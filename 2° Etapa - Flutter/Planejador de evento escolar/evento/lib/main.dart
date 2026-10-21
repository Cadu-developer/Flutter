import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'screens/configuracao.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const FeiraEscolarApp(),
    ),
  );
}

class FeiraEscolarApp extends StatelessWidget {
  const FeiraEscolarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feira Escolar App',
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const ConfiguracaoScreen(),
    );
  }
}