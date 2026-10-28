import '../models/usuario.dart';
import '../services/usuario_service.dart';

class UsuarioProvider {
  final UsuarioService service = UsuarioService();

  Future<bool> cadastrar(Usuario usuario) {
    return service.cadastrarUsuario(usuario);
  }

  Future<Usuario?> entrar(String email, String senha) {
    return service.login(email, senha);
  }
}