import 'package:flutter/material.dart';
import 'tela_informacoes.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final TextEditingController nomeController = TextEditingController(); 
  final TextEditingController nomePetController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();

  String mensagemErro = ''; 
  String mensagemSucesso = ''; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock,
                size: 80,
                color: Colors.blue,
              ),

              const SizedBox(height: 10),

              const Text(
                'Digite seu email e senha para acessar o app.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 30),

              TextField(
                controller: nomeController,
                keyboardType:
                TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Seu nome',
                  hintText:
                      'Ex: Carlos',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: nomePetController, 
                decoration: const InputDecoration(
                  labelText: 'Nome do seu pet',
                  hintText: 'Ex: Jorginho',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                mensagemErro,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

               const SizedBox(height: 15),

              TextField(
                controller: telefoneController, 
                decoration: const InputDecoration(
                  labelText: 'Seu telefone',
                  hintText: 'Ex: (xx) xxxxx-xxxx',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),
              Text(
                mensagemErro,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: () {
                  String nome = nomeController.text; 
                  String nomePet = nomePetController.text; 
                  String telefone = telefoneController.text;

                  if (nome.isEmpty || nomePet.isEmpty || telefone.isEmpty) {
                    setState(() {
                      mensagemErro = 'Campo(s) invalido(s)!';
                    });
                  } 
                  
                  else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const  Informacoes(),
                      ),
                    );
    }
  },  label: const Text('Ver informações')
),
            ],
          ),
        ),
      ),
    );
  }
}