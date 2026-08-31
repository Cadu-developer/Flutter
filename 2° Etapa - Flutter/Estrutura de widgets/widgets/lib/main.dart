import 'package:flutter/material.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaPrincipal(),
    );
  }
}

class TelaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CARLOS EDUARDO MEDEIROS DOS SANTOS'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  'https://upload.wikimedia.org/wikipedia/pt/3/3a/Interstellar_Filme.png',
                  height: 220,
                  fit: BoxFit.cover,
                ),

                SizedBox(height: 16),

                Text(
                  'Interestelar',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 12),

                Text(
                  'Interestelar é um filme de ficção científica dirigido por Christopher Nolan. '
                  'A história acompanha astronautas que viajam pelo espaço em busca de um novo lar '
                  'para a humanidade, enquanto enfrentam desafios científicos e emocionais.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    print("Botão pressionado!");
                  },
                  child: Text('Ver detalhes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

