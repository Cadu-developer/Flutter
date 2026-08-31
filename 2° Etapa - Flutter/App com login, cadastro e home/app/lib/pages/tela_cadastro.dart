import 'package:flutter/material.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController =
      TextEditingController();
  final TextEditingController nomeController = TextEditingController();

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
                'Criar Conta',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),

              // Campo Nome
              TextField(
                controller: nomeController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  hintText: 'Digite seu nome',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),

              const SizedBox(height: 15),

              // Campo Email
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Digite seu email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),

              const SizedBox(height: 15),

              // Campo Senha
              TextField(
                controller: senhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Digite sua senha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),

              const SizedBox(height: 15),

              // Campo Confirmar Senha
              TextField(
                controller: confirmarSenhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirmar Senha',
                  hintText: 'Confirme sua senha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
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

              Text(
                mensagemSucesso,
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: () {
                  String email = emailController.text.trim();
                  String senha = senhaController.text;
                  String confirmarSenha = confirmarSenhaController.text;

                  if (nomeController.text.isEmpty) {
                    setState(() {
                      mensagemErro = 'Digite seu nome';
                      mensagemSucesso = '';
                    });
                  } else if (email.isEmpty) {
                    setState(() {
                      mensagemErro = 'Digite seu email';
                      mensagemSucesso = '';
                    });
                  } else if (!email.contains('@')) {
                    setState(() {
                      mensagemErro = 'Digite um email válido';
                      mensagemSucesso = '';
                    });
                  } else if (senha.isEmpty) {
                    setState(() {
                      mensagemErro = 'Digite sua senha';
                      mensagemSucesso = '';
                    });
                  } else if (senha.length < 6) {
                    setState(() {
                      mensagemErro =
                          'A senha precisa ter pelo menos 6 caracteres';
                      mensagemSucesso = '';
                    });
                  } else if (senha != confirmarSenha) {
                    setState(() {
                      mensagemErro = 'As senhas não são iguais';
                      mensagemSucesso = '';
                    });
                  } else {
                    setState(() {
                      mensagemErro = '';
                      mensagemSucesso =
                          'Cadastro realizado com sucesso!';
                    });
                  }
                },
                icon: const Icon(Icons.person_add),
                label: const Text('Cadastrar'),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Voltar para Login',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}