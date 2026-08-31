import 'package:flutter/material.dart';

void main() {
  runApp(const MeuAppDeMusica());
}

class MeuAppDeMusica extends StatelessWidget {
  const MeuAppDeMusica({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: Colors.greenAccent,
        ),
      ),
      home: const TelaMusica(),
    );
  }
}

class TelaMusica extends StatefulWidget {
  const TelaMusica({super.key});

  @override
  State<TelaMusica> createState() => _TelaMusicaState();
}

class _TelaMusicaState extends State<TelaMusica> {

  String filtroSelecionado = 'Tudo';
  final List<String> categorias = ['Tudo', 'Rock', 'Pop', 'Lo-Fi'];
  String? musicaTocando;
  bool estaTocando = false;

  final List<Map<String, String>> playlist = [
    {
      'titulo': 'Bohemian Rhapsody',
      'artista': 'Queen',
      'duracao': '5:55',
      'categoria': 'Rock',
      'detalhes': 'Álbum: A Night at the Opera (1975). Lançada como single principal do álbum.'
    },
    {
      'titulo': 'Blinding Lights',
      'artista': 'The Weeknd',
      'duracao': '3:20',
      'categoria': 'Pop',
      'detalhes': 'Álbum: After Hours (2020). Uma das músicas mais ouvidas no Spotify.'
    },
    {
      'titulo': 'Midnight Study Session',
      'artista': 'ChilledCow',
      'duracao': '2:45',
      'categoria': 'Lo-Fi',
      'detalhes': 'Faixa ideal para foco, relaxamento e estudos noturnos.'
    },
    {
      'titulo': 'Hotel California',
      'artista': 'Eagles',
      'duracao': '6:30',
      'categoria': 'Rock',
      'detalhes': 'Álbum: Hotel California (1976). Famosa pelo seu solo final de guitarra.'
    },
  ];

  @override
  Widget build(BuildContext context) {

    final musicasFiltradas = filtroSelecionado == 'Tudo'
        ? playlist
        : playlist.where((m) => m['categoria'] == filtroSelecionado).toList();

    return Scaffold(
      /*
        WIDGET NOVO 1: CustomScrollView
        Permite combinar diferentes comportamentos de rolagem em uma só tela.
      */
      body: CustomScrollView(
        slivers: [
          /*
            WIDGET NOVO 2: SliverAppBar
            Barra superior customizada que expande/colapsa ao rolar a página.
          */
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Minha Playlist',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green, Color(0xFF121212)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.music_note,
                    size: 80,
                    color: Colors.white24,
                  ),
                ),
              ),
            ),
          ),

          // Seção de Filtros por Categoria
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categorias.map((categoria) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      /*
                        WIDGET NOVO 3: ChoiceChip
                        Chip interativo que permite selecionar uma categoria específica.
                      */
                      child: ChoiceChip(
                        label: Text(categoria),
                        selected: filtroSelecionado == categoria,
                        selectedColor: Colors.greenAccent,
                        labelStyle: TextStyle(
                          color: filtroSelecionado == categoria
                              ? Colors.black
                              : Colors.white,
                        ),
                        onSelected: (bool selected) {
                          setState(() {
                            filtroSelecionado = categoria;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          // Lista de Músicas
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final musica = musicasFiltradas[index];
                final estaSelecionada = musicaTocando == musica['titulo'];

                /*
                  WIDGET NOVO 4: ExpansionTile
                  Item da lista que abre e fecha ao ser clicado para exibir mais detalhes.
                */
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  color: const Color(0xFF1E1E1E),
                  child: ExpansionTile(
                    leading: Icon(
                      Icons.disc_full,
                      color: estaSelecionada ? Colors.greenAccent : Colors.grey,
                    ),
                    title: Text(
                      musica['titulo']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: estaSelecionada ? Colors.greenAccent : Colors.white,
                      ),
                    ),
                    subtitle: Text('${musica['artista']} • ${musica['duracao']}'),
                    trailing: IconButton(
                      icon: Icon(
                        (estaSelecionada && estaTocando)
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_fill,
                        color: Colors.greenAccent,
                        size: 32,
                      ),
                      onPressed: () {
                        setState(() {
                          if (estaSelecionada) {
                            estaTocando = !estaTocando;
                          } else {
                            musicaTocando = musica['titulo'];
                            estaTocando = true;
                          }
                        });
                      },
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          musica['detalhes']!,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: musicasFiltradas.length,
            ),
          ),
        ],
      ),

      // Mini player fixo na parte inferior quando há alguma música selecionada
      bottomNavigationBar: musicaTocando != null
          ? Container(
              color: const Color(0xFF282828),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.music_note, color: Colors.greenAccent),
                      const SizedBox(width: 12),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            musicaTocando!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'Reproduzindo agora',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      estaTocando ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        estaTocando = !estaTocando;
                      });
                    },
                  ),
                ],
              ),
            )
          : null,
    );
  }
}