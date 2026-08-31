import 'package:flutter/material.dart';
import '../widgets/card_icone.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({super.key});

  @override
  State<TelaHome> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  String mensagem = 'Clique em um botão';

  void atualizarMensagem(String texto) {
    setState(() {
      mensagem = texto;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu App de Ícones'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            mensagem = 'Você clicou no FloatingActionButton';
          });
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              mensagem,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            CardIcone(
              icone: Icons.person,
              titulo: 'Perfil',
              descricao: 'Veja suas informações pessoais.',
              textoBotao: 'Abrir',
              cor: Colors.blue,
              onPressed: () {
                atualizarMensagem('Você clicou em Perfil');
              },
            ),
            CardIcone(
              icone: Icons.settings,
              titulo: 'Configurações',
              descricao: 'Ajuste as configurações do app.',
              textoBotao: 'Configurar',
              cor: Colors.orange,
              onPressed: () {
                atualizarMensagem('Você clicou em Configurações');
              },
            ),
            CardIcone(
              icone: Icons.favorite,
              titulo: 'Favoritos',
              descricao: 'Veja seus itens favoritos.',
              textoBotao: 'Ver',
              cor: Colors.red,
              onPressed: () {
                atualizarMensagem('Você clicou em Favoritos');
              },
            ),
            CardIcone(
              icone: Icons.message,
              titulo: 'Mensagens',
              descricao: 'Confira suas mensagens.',
              textoBotao: 'Abrir',
              cor: Colors.green,
              onPressed: () {
                atualizarMensagem('Você clicou em Mensagens');
              },
            ),
          ],
        ),
      ),
    );
  }
}
