import 'package:flutter/material.dart';

class TelaPerfil extends StatefulWidget {
  const TelaPerfil({super.key});

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  final TextEditingController nomeController = TextEditingController();

  final TextEditingController estiloController = TextEditingController();

  String nomeSalvo = '';
  String estiloSalvo = '';

  String mensagemErro = '';

  void salvarPerfil() {
    final String nome = nomeController.text.trim();

    final String estilo = estiloController.text.trim();

    if (nome.isEmpty || estilo.isEmpty) {
      setState(() {
        mensagemErro = 'Preencha todos os campos.';
      });
      return;
    }

    setState(() {
      nomeSalvo = nome;
      estiloSalvo = estilo;
      mensagemErro = '';
    });
  }

  @override
  void dispose() {
    nomeController.dispose();
    estiloController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu perfil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Icon(
              Icons.account_circle,
              size: 100,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                prefixIcon: Icon(
                  Icons.person,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: estiloController,
              decoration: const InputDecoration(
                labelText: 'Estilo musical favorito',
                prefixIcon: Icon(
                  Icons.music_note,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            if (mensagemErro.isNotEmpty)
              Text(
                mensagemErro,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: salvarPerfil,
              child: const Text(
                'Salvar perfil',
              ),
            ),
            const SizedBox(height: 30),
            if (nomeSalvo.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      size: 45,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Perfil salvo!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Nome: $nomeSalvo',
                    ),
                    Text(
                      'Estilo favorito: $estiloSalvo',
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 30),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Voltar para o player',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
