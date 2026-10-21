import 'package:flutter/material.dart';
import '../widgets/cartao_objeto.dart';
import 'tela_comprovante.dart';

class TelaCadastroObjeto extends StatefulWidget {
  const TelaCadastroObjeto({super.key});

  @override
  State<TelaCadastroObjeto> createState() => _TelaCadastroObjetoState();
}

class _TelaCadastroObjetoState extends State<TelaCadastroObjeto> {
  final _nomeController = TextEditingController();
  final _localController = TextEditingController();

  int _totalRegistros = 0;
  String _ultimoNome = '';
  String _ultimoLocal = '';
  String _situacao = 'Aguardando retirada';
  bool _temRegistro = false;

  void _registrarObjeto() {
    if (_nomeController.text.trim().isEmpty || _localController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todas as informações.')),
      );
      return;
    }

    setState(() {
      _totalRegistros++;
      _ultimoNome = _nomeController.text.trim();
      _ultimoLocal = _localController.text.trim();
      _situacao = 'Aguardando retirada';
      _temRegistro = true;

      _nomeController.clear();
      _localController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Objeto cadastrado com sucesso!')),
    );
  }

  void _alterarSituacao() {
    setState(() {
      if (_situacao == 'Aguardando retirada') {
        _situacao = 'Objeto devolvido';
      } else {
        _situacao = 'Aguardando retirada';
      }
    });
  }

  void _abrirComprovante() {
    if (!_temRegistro) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registre um objeto antes de abrir o comprovante.')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaComprovante(
          nome: _ultimoNome,
          local: _ultimoLocal,
          situacao: _situacao,
          totalRegistros: _totalRegistros,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _localController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achados e Perdidos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double paddingHorizontal = constraints.maxWidth > 600 ? 64.0 : 16.0;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.search_off, size: 80, color: Colors.deepPurple),
                const SizedBox(height: 16),
                TextField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do objeto',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _localController,
                  decoration: const InputDecoration(
                    labelText: 'Local onde foi encontrado',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _registrarObjeto,
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                  child: const Text('Registrar objeto', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 16),
                Text(
                  'Total de registros realizados: $_totalRegistros',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                if (_temRegistro) ...[
                  CartaoObjeto(
                    nome: _ultimoNome,
                    local: _ultimoLocal,
                    situacao: _situacao,
                    cor: _situacao == 'Aguardando retirada'
                        ? Colors.amber.shade100
                        : Colors.green.shade100,
                    aoApertarBotao: _alterarSituacao,
                  ),
                  const SizedBox(height: 16),
                ],
                OutlinedButton(
                  onPressed: _abrirComprovante,
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(16)),
                  child: const Text('Ver comprovante', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}