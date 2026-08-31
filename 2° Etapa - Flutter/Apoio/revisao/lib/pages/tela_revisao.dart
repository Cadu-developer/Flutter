import 'package:flutter/material.dart';

class TelaRevisao extends StatefulWidget {
  // A tela pode mudar de estado
  const TelaRevisao({super.key});

  @override
  State<TelaRevisao> createState() => _TelaRevisaoState();
  // _TelaRevisaoState é onde ficam os dados que podem mudar
}

class _TelaRevisaoState extends State<TelaRevisao> {
  String mensagem = 'Clique em uma opção';

  @override
  Widget build(BuildContext context) {
    // É o método que monta a interface
    return Scaffold(
      // Corpo da aplicação

      appBar: AppBar(
        // Cabeçalho da aplicação
        title: const Text('Revisão Flutter'),
      ),

      body: SafeArea(
  // Proteger o conteúdo da área notch (bordas, câmera)
  child: Padding(
    // Cria espaço
    padding: const EdgeInsets.all(20),

    child: Column(
      // Organiza os widgets na vertical
      mainAxisAlignment: MainAxisAlignment.center,

      // É usado para a coluna receber vários widgets
      children: [
        const Text('Conteúdo da tela'),
        const SizedBox(height: 10),

const Text(
  'Vamos revisar widgets, layout, estilo, botões, estado e navegação.',
  textAlign: TextAlign.center,

  style: TextStyle(
    fontSize: 16,
  ),
),


Container(
  // Funciona como uma caixa para mexer no estilo
  width: 320, // Limita largura

  padding: const EdgeInsets.all(16), // Cria espaço
  margin: const EdgeInsets.all(10),

  decoration: BoxDecoration(
    color: Colors.blue.shade50,

    borderRadius: BorderRadius.circular(16),
  ),

  child: const Text(
    'O Container funciona como uma caixa. Ele pode ter largura, padding, margin, cor e bordas.',

    textAlign: TextAlign.center,
  ),
),
const SizedBox(height: 20),

Text(
  mensagem, // mensagem que a gente colocou na linha 13
  // que muda o estado do componente é o parâmetro onPressed
  style: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ), // TextStyle
  textAlign: TextAlign.center,
), // Text

const SizedBox(height: 20),
Row(
  // controles em uma linha
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: <Widget>[
    ElevatedButton(
      onPressed: () {
        setState(() {
          mensagem = 'Você clicou no botão Azul';
        });
      },
      child: const Text('Azul'),
    ), // ElevatedButton

    ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 14,
        ),
        elevation: 4,
      ),
      onPressed: () {
        setState(() {
          mensagem = 'Você clicou no botão Destaque';
        });
      },
      child: const Text('Destaque'),
    ), // ElevatedButton
  ],
), // Row
    ],
  ),
),
  
),

      floatingActionButton: FloatingActionButton(
        // Botão flutuante
        onPressed: () {
          setState(() {
            mensagem = 'Você clicou no botão flutuante';
          });
        },

        child: const Icon(Icons.add),
      ),




    );
  }
}

