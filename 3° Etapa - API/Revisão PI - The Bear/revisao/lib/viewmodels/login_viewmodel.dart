import 'package:flutter/material.dart';

import '../models/usuario.dart';
import '../services/banco_service.dart';

class LoginViewModel extends ChangeNotifier {
  final BancoService bancoService;

  LoginViewModel({
    required this.bancoService,
  });

  bool carregando = false;
  String? erro;
  Usuario? usuarioLogado;

  Future<bool> login(
    String email,
    String senha,
  ) async {
    carregando = true;
    erro = null;

    notifyListeners();

    try {
      final emailLimpo = email.trim();

      if (emailLimpo.isEmpty || senha.isEmpty) {
        erro = 'Preencha o e-mail e a senha.';
        return false;
      }

      final usuario = await bancoService.autenticar(
        emailLimpo,
        senha,
      );

      if (usuario == null) {
        erro = 'E-mail ou senha inválidos.';
        return false;
      }

      usuarioLogado = usuario;

      return true;
    } catch (e) {
      erro = 'Erro ao realizar login: $e';

      debugPrint('ERRO LOGIN: $e');

      return false;
    } finally {
      carregando = false;
      notifyListeners();
    }
  }

  Future<bool> cadastrar(
    String nome,
    String email,
    String senha,
  ) async {
    try {
      if (nome.trim().isEmpty ||
          email.trim().isEmpty ||
          senha.isEmpty) {
        erro = 'Preencha todos os campos.';
        notifyListeners();
        return false;
      }

      final usuario = Usuario(
        nome: nome.trim(),
        email: email.trim(),
        senha: senha,
      );

      await bancoService.inserirUsuario(usuario);

      erro = null;

      return true;
    } catch (e) {
      erro = 'Erro no cadastro: $e';

      debugPrint('ERRO CADASTRO: $e');

      notifyListeners();

      return false;
    }
  }
}