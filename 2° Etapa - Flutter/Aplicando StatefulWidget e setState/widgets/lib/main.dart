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

// Agora a tela é StatefulWidget
class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

// Classe State
class _TelaPrincipalState extends State<TelaPrincipal> {
  // Variável que muda durante a execução
  String mensagem = 'Clique no botão para saber mais!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CARLOS EDUARDO MEDEIROS DOS SANTOS'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Imagem
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/pt/3/3a/Interstellar_Filme.png',
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(height: 20),

                  // Título
                  Text(
                    'Interestelar',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 15),

                  // Descrição
                  Text(
                    'Interestelar é um filme de ficção científica dirigido por Christopher Nolan. '
                    'A história acompanha astronautas que viajam pelo espaço em busca de um novo lar '
                    'para a humanidade, enfrentando desafios científicos e emocionais.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(height: 20),

                  // Mensagem dinâmica
                  Text(
                    mensagem,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),

                  SizedBox(height: 20),

                  // Botão
                  ElevatedButton(
                    onPressed: () {
                      // Atualiza a interface
                      setState(() {
                        mensagem =
                            'Esse filme marcou uma geração por sua história emocionante e pelos efeitos incríveis.';
                      });
                    },
                    child: Text('Ver detalhes'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
