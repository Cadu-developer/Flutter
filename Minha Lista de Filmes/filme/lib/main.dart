import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';
import 'viewmodels/filme_viewmodel.dart';
import 'pages/pagina_inicial.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true, // Defina como false se quiser desativar em produção
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FilmeViewModel(),
      child: MaterialApp(
        // Configurações obrigatórias do DevicePreview
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        
        title: 'Minha Lista de Filmes',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PaginaInicial(),
      ),
    );
  }
}