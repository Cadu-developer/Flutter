import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'services/banco_service.dart';
import 'viewmodels/login_viewmodel.dart';
import 'viewmodels/pedido_viewmodel.dart';
import 'pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  databaseFactory = databaseFactoryFfiWeb;

  runApp(const TheBearApp());
}

class TheBearApp extends StatelessWidget {
  const TheBearApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bancoService = BancoService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(
            bancoService: bancoService,
          ),
        ),

        ChangeNotifierProvider(
          create: (_) => PedidoViewModel(
            bancoService: bancoService,
          ),
        ),
      ],

      child: DevicePreview(
        enabled: true,

        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,

          useInheritedMediaQuery: true,

          title: 'The Bear',

          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.brown,
            ),
            useMaterial3: true,
          ),

          home: const LoginPage(),
        ),
      ),
    );
  }
}