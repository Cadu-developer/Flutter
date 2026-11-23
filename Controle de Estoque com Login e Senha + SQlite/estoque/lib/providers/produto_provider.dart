import '../models/produto.dart';
import '../services/produto_service.dart';

class ProdutoProvider {
  final ProdutoService service = ProdutoService();

  Future<void> cadastrar(Produto produto) {
    return service.cadastrarProduto(produto);
  }

  Future<List<Produto>> listar() {
    return service.listarProdutos();
  }

  Future<void> atualizarQuantidade(int id, int quantidade) {
    return service.alterarQuantidade(id, quantidade);
  }

  Future<void> excluir(int id) {
    return service.excluirProduto(id);
  }

  Future<void> mostrarNoTerminal() {
    return service.mostrarProdutosNoTerminal();
  }
}