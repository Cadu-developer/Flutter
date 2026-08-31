import 'package:flutter/material.dart';
import '../models/model.dart';
import 'resumo.dart';

class ConfiguracaoScreen extends StatefulWidget {
  const ConfiguracaoScreen({super.key});

  @override
  State<ConfiguracaoScreen> createState() => _ConfiguracaoScreenState();
}

class _ConfiguracaoScreenState extends State<ConfiguracaoScreen> {
  final AtividadeModel _atividade = AtividadeModel();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _responsavelController = TextEditingController();
  final TextEditingController _localController = TextEditingController();

  void _atualizarProjetor() {
    if (_atividade.tipo == TipoAtividade.palestra) {
      _atividade.projetor = true;
    }
  }

  void _limparFormulario() {
    setState(() {
      _atividade.resetar();
      _nomeController.clear();
      _responsavelController.clear();
      _localController.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Formulário restaurado com sucesso!')),
    );
  }

  void _finalizar() {
    String? erro = _atividade.validarIncompleto();
    if (erro != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(erro), backgroundColor: Colors.red),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResumoScreen(atividade: _atividade),
        ),
      );
    }
  }
  Map<String, dynamic> _obterEstiloPainel() {
    switch (_atividade.tipo) {
      case TipoAtividade.oficina:
        return {
          'cor': Colors.orange.shade100,
          'icone': Icons.build,
          'borda': BorderRadius.circular(16),
          'msg': 'Sessão Prática e Mão na Massa'
        };
      case TipoAtividade.palestra:
        return {
          'cor': Colors.blue.shade100,
          'icone': Icons.record_voice_over,
          'borda': BorderRadius.circular(8),
          'msg': 'Apresentação Teórica / Auditório'
        };
      case TipoAtividade.exposicao:
        return {
          'cor': Colors.purple.shade100,
          'icone': Icons.palette,
          'borda': BorderRadius.circular(24),
          'msg': 'Mostra Visual Aberta'
        };
      case TipoAtividade.competicao:
        return {
          'cor': Colors.red.shade100,
          'icone': Icons.emoji_events,
          'borda': BorderRadius.circular(4),
          'msg': 'Desafio Acadêmico'
        };
      case TipoAtividade.apresentacaoCultural:
        return {
          'cor': Colors.teal.shade100,
          'icone': Icons.theater_comedy,
          'borda': BorderRadius.circular(20),
          'msg': 'Evento Artístico'
        };
      default:
        return {
          'cor': Colors.grey.shade200,
          'icone': Icons.help_outline,
          'borda': BorderRadius.circular(12),
          'msg': 'Selecione um tipo acima'
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final estiloPainel = _obterEstiloPainel();
    final alertas = _atividade.obterAlertas();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuração da Atividade'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Text(
                'Menu do Evento',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Nova Atividade'),
              onTap: () {
                Navigator.pop(context);
                _limparFormulario();
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Atividade Atual'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.cleaning_services),
              title: const Text('Limpar Formulário'),
              onTap: () {
                Navigator.pop(context);
                _limparFormulario();
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Sobre o Evento'),
              onTap: () {
                Navigator.pop(context);
                showAboutDialog(
                  context: context,
                  applicationName: 'Feira Escolar App',
                  applicationVersion: '1.0.0',
                  children: [const Text('Aplicativo para planejamento e validação de atividades da feira escolar.')],
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: estiloPainel['cor'],
                borderRadius: estiloPainel['borda'],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(estiloPainel['icone'], size: 28),
                      const SizedBox(width: 8),
                      Text(
                        _atividade.nome.isEmpty ? 'Nome da Atividade' : _atividade.nome,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Tipo: ${_atividade.tipo?.nome ?? "Não selecionado"}'),
                  Text('Duração: ${_atividade.duracaoFormatada}'),
                  Text('Capacidade: ${_atividade.participantes.round()} (${_atividade.classificacao})'),
                  Text('Recursos Ativos: ${_atividade.quantidadeRecursosAtivos}'),
                  Text('Informação: ${estiloPainel['msg']}'),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Text('Informações Iniciais', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome da Atividade'),
              onChanged: (v) => setState(() => _atividade.nome = v),
            ),
            TextField(
              controller: _responsavelController,
              decoration: const InputDecoration(labelText: 'Nome do Responsável'),
              onChanged: (v) => setState(() => _atividade.responsavel = v),
            ),
            TextField(
              controller: _localController,
              decoration: const InputDecoration(labelText: 'Sala ou Local'),
              onChanged: (v) => setState(() => _atividade.local = v),
            ),

            const SizedBox(height: 20),
            const Text('Tipo de Atividade', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: TipoAtividade.values.map((tipo) {
                return ChoiceChip(
                  label: Text(tipo.nome),
                  selected: _atividade.tipo == tipo,
                  onSelected: (selected) {
                    setState(() {
                      _atividade.tipo = selected ? tipo : null;
                      _atualizarProjetor();
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            //Definição da Duração
            const Text('Duração da Atividade', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Selecionado: ${_atividade.duracaoFormatada}'),
            Slider(
              value: _atividade.duracaoMinutos,
              min: 15,
              max: 180,
              divisions: 33, 
              label: _atividade.duracaoFormatada,
              onChanged: (v) => setState(() => _atividade.duracaoMinutos = v),
            ),

            const SizedBox(height: 20),

            // 5. Regra de Capacidade
            const Text('Capacidade de Participantes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('${_atividade.participantes.round()} participantes - ${_atividade.classificacao}'),
            Slider(
              value: _atividade.participantes,
              min: 5,
              max: 100,
              divisions: 95,
              label: '${_atividade.participantes.round()}',
              onChanged: (v) => setState(() => _atividade.participantes = v),
            ),

            const SizedBox(height: 10),

            ExpansionTile(
              title: const Text('Recursos Necessários', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${_atividade.quantidadeRecursosAtivos} recursos ativados'),
              children: [
                SwitchListTile(
                  title: const Text('Projetor'),
                  value: _atividade.projetor,
                  onChanged: (v) => setState(() => _atividade.projetor = v),
                ),
                SwitchListTile(
                  title: const Text('Computadores'),
                  value: _atividade.computadores,
                  onChanged: (v) => setState(() => _atividade.computadores = v),
                ),
                SwitchListTile(
                  title: Row(
                    children: [
                      const Text('Sistema de som '),
                      if (_atividade.tipo == TipoAtividade.apresentacaoCultural)
                        const Text('(Recomendado)', style: TextStyle(color: Colors.orange, fontSize: 12)),
                    ],
                  ),
                  value: _atividade.sistemaSom,
                  onChanged: (v) => setState(() => _atividade.sistemaSom = v),
                ),
                SwitchListTile(
                  title: const Text('Acesso à internet'),
                  value: _atividade.internet,
                  onChanged: (v) => setState(() => _atividade.internet = v),
                ),
                SwitchListTile(
                  title: const Text('Mesas adicionais'),
                  value: _atividade.mesasAdicionais,
                  onChanged: (v) => setState(() => _atividade.mesasAdicionais = v),
                ),
              ],
            ),

            if (alertas.isNotEmpty) ...[
              const SizedBox(height: 10),
              ...alertas.map((msg) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        const Icon(Icons.warning_amber_rounded, color: Colors.orange),
                        const SizedBox(width: 8),
                        Expanded(child: Text(msg, style: const TextStyle(color: Colors.orange))),
                      ],
                    ),
                  )),
            ],

            const SizedBox(height: 80), 
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _finalizar,
        icon: const Icon(Icons.analytics),
        label: Text('Analisar - ${_atividade.etapasConcluidas} de 7'),
      ),
    );
  }
}