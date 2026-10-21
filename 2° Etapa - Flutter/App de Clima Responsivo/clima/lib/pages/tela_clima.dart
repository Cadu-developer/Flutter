import 'package:flutter/material.dart';

import '../models/cidade_clima.dart';
import '../widgets/area_cidades.dart';
import '../widgets/painel_informacoes.dart';

class TelaClima extends StatelessWidget {
  TelaClima({super.key});

  final cidades = [
    CidadeClima(
      nome: "Belo Horizonte",
      temperatura: 28,
      condicao: "Ensolarado",
      icone: "☀️",
      imagem:
          "https://picsum.photos/200?1",
    ),
    CidadeClima(
      nome: "São Paulo",
      temperatura: 22,
      condicao: "Nublado",
      icone: "☁️",
      imagem:
          "https://picsum.photos/200?2",
    ),
    CidadeClima(
      nome: "Curitiba",
      temperatura: 17,
      condicao: "Chuvoso",
      icone: "🌧️",
      imagem:
          "https://picsum.photos/200?3",
    ),
    CidadeClima(
      nome: "Rio de Janeiro",
      temperatura: 31,
      condicao: "Quente",
      icone: "🔥",
      imagem:
          "https://picsum.photos/200?4",
    ),
    CidadeClima(
      nome: "Brasília",
      temperatura: 25,
      condicao: "Vento Forte",
      icone: "💨",
      imagem:
          "https://picsum.photos/200?5",
    ),
    CidadeClima(
      nome: "Porto Alegre",
      temperatura: 19,
      condicao: "Frio",
      icone: "❄️",
      imagem:
          "https://picsum.photos/200?6",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final largura =
        MediaQuery.of(context).size.width;

    bool celular = largura < 600;
    bool tablet =
        largura >= 600 && largura < 900;
    bool desktop = largura >= 900;

    int colunas = celular
        ? 1
        : tablet
            ? 2
            : 3;

    List<CidadeClima> cidadesExibidas =
        celular
            ? cidades.take(4).toList()
            : cidades;

    return Scaffold(
      appBar: AppBar(
        title: Text("Clima Agora"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [

                AspectRatio(
                  aspectRatio: 4,
                  child: Container(
                    color: Colors.blue,
                    child: Center(
                      child: FittedBox(
                        child: Column(
                          children: [
                            Text(
                              "☀ Clima Agora",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                            Text(
                              "Confira as condições do tempo em diversas cidades.",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    "Ensolarado",
                    "Chuvoso",
                    "Frio",
                    "Quente",
                    "Nublado",
                    "Vento Forte",
                    "Tempestade",
                  ]
                      .map(
                        (e) => Chip(
                          label: Text(e),
                        ),
                      )
                      .toList(),
                ),

                SizedBox(height: 20),

                Text(
                  "Largura atual: ${largura.toStringAsFixed(0)} px",
                ),

                Text(
                  "Dispositivo: ${celular ? "Celular" : tablet ? "Tablet" : "Desktop"}",
                ),

                if (tablet)
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Ver previsão para 7 dias",
                    ),
                  ),

                SizedBox(height: 20),

                if (desktop)
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: AreaCidades(
                          cidades: cidadesExibidas,
                          colunas: colunas,
                        ),
                      ),

                      SizedBox(width: 20),

                      Expanded(
                        child:
                            PainelInformacoes(),
                      ),
                    ],
                  )
                else ...[
                  AreaCidades(
                    cidades: cidadesExibidas,
                    colunas: colunas,
                  ),
                  SizedBox(height: 20),
                  PainelInformacoes(),
                ],

                if (celular)
                  Card(
                    child: Padding(
                      padding:
                          EdgeInsets.all(16),
                      child: Text(
                        "Cidade em destaque: Belo Horizonte",
                      ),
                    ),
                  ),

                if (desktop)
                  Padding(
                    padding:
                        EdgeInsets.only(top: 20),
                    child: Text(
                      "Dados climáticos atualizados em tempo real.",
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}