import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import './pages/pageOne.dart';

void main() {
  // O DevicePreview ajuda a testar o layout em diferentes tamanhos de tela
  runApp(DevicePreview(
    builder: (context) => MeuApp(),
  ));
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove a faixa de debug
      theme: ThemeData(
        useMaterial3: true, // Ativa o Material Design 3
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          secondary: Colors.redAccent,
        ),
      ),
      home: TeladDesign(),
    );
  }
}





// class TextosPergunta extends StatelessWidget {
//   final String texto;

//   const TextosPergunta(this.texto, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.all(20),
//       child: Text(
//         texto,
//         style: const TextStyle(
//           fontSize: 28,
//           fontWeight: FontWeight.bold,
//           color: Colors.black87,
//         ),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
// }

// class TelaContador extends StatefulWidget {
//   @override
//   State<TelaContador> createState() => _TelaContadorState();
// }

// class _TelaContadorState extends State<TelaContador> {
//   int contador = 0;

//   void aumentar() {
//     setState(() {
//       contador++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text('Contador: $contador'),
//         ElevatedButton(
//           onPressed: aumentar,
//           child: Text('Aumentar'),
//         ),
//       ],
//     );
//   }
// }
