import 'package:desafio/pages/tela_cadastro.dart';
import 'package:flutter/material.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController emailController =
      TextEditingController(); // Guarda o texto digitado para o email

  final TextEditingController senhaController =
      TextEditingController(); // Guarda o texto digitado para a senha

  String mensagemErro = ''; // String que vamos usar para definir erros

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                // Cria um campo para digitar um texto
                controller: emailController, // Liga o campo ao controlador
                keyboardType:
                    TextInputType.emailAddress, // Define o tipo de teclado
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText:
                      'Digite seu email', // Texto dentro do campo (Placeholder)
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                // Cria um campo para digitar a senha
                controller: senhaController, // Liga o campo ao controlador
                obscureText: true, // Oculta os caracteres digitados
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Digite sua senha',
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
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // ao pressionar

                  String email = emailController
                      .text; // vai definir se o usuário colocou email correto
                  String senha = senhaController
                      .text; // vai definir se o usuário colocou senha correta

                  if (!email.contains('@')) {
                    // se o email não conter o @, dá erro

                    setState(() {
                      mensagemErro = 'Digite um email válido';
                    });
                  } else if (senha.isEmpty) {
                    // se a senha estiver vazia, dá erro

                    setState(() {
                      mensagemErro = 'Digite sua senha';
                    });
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TelaLogin(),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.login),
                label: const Text('Entrar'),
              ),
            TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TelaCadastro(),
      ),
    );
  },
  child: const Text(
    'Não tem uma conta? Cadastre-se aqui.',
    style: TextStyle(
      color: Colors.blue,
    ),
  ),
)
            ],
          ),
        ),
      ),
    );
  }
}
