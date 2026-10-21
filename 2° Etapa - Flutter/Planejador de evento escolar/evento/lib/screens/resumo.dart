import 'package:flutter/material.dart';
import '../models/model.dart';

class ResumoScreen extends StatelessWidget {
  final AtividadeModel atividade;

  const ResumoScreen({super.key, required this.atividade});

  @override
  Widget build(BuildContext context) {
    List<String> alertas = atividade.obterAlertas();
    bool pronta = alertas.isEmpty;

    double porcentagem = atividade.etapasConcluidas / 7;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo e Análise'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: pronta ? Colors.green.shade100 : Colors.amber.shade100,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      pronta ? Icons.check_circle : Icons.warning,
                      color: pronta ? Colors.green : Colors.amber.shade900,
                      size: 40,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pronta ? 'Pronta para cadastro' : 'Requer atenção',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: pronta ? Colors.green.shade900 : Colors.amber.shade900,
                            ),
                          ),
                          if (!pronta)
                            const Text('Existem avisos importantes que precisam de validação.'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Progresso de Configuração (${atividade.etapasConcluidas} / 7)',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: porcentagem,
              minHeight: 12,
              borderRadius: BorderRadius.circular(6),
              backgroundColor: Colors.grey.shade300,
              color: pronta ? Colors.green : Colors.amber,
            ),
            Text('${(porcentagem * 100).round()}% concluído'),

            const SizedBox(height: 20),

            if (alertas.isNotEmpty) ...[
              const Text('Avisos e Observações:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...alertas.map((alerta) => Card(
                    color: Colors.orange.shade50,
                    child: ListTile(
                      leading: const Icon(Icons.info_outline, color: Colors.orange),
                      title: Text(alerta),
                    ),
                  )),
              const SizedBox(height: 20),
            ],

            const Text('Tabela de Informações', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Informação', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Valor', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: [
                  DataRow(cells: [
                    const DataCell(Text('Atividade')),
                    DataCell(Text(atividade.nome)),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Responsável')),
                    DataCell(Text(atividade.responsavel)),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Local')),
                    DataCell(Text(atividade.local)),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Tipo')),
                    DataCell(Text(atividade.tipo?.nome ?? '-')),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Duração')),
                    DataCell(Text(atividade.duracaoFormatada)),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Capacidade')),
                    DataCell(Text('${atividade.participantes.round()} participantes')),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Classificação')),
                    DataCell(Text(atividade.classificacao)),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Recursos ativos')),
                    DataCell(Text('${atividade.quantidadeRecursosAtivos}')),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Situação')),
                    DataCell(Text(pronta ? 'Pronta para cadastro' : 'Requer atenção')),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}