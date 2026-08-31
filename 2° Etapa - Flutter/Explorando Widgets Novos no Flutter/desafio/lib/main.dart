import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const CineBoxApp(),
    ),
  );
}

class CineBoxApp extends StatelessWidget {
  const CineBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      title: 'CineBox',

      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.dark,
      ),

      home: const CineBoxHome(),
    );
  }
}

class Filme {
  final String titulo;
  final String genero;
  final int ano;
  final double nota;
  final String duracao;
  final String descricao;
  final IconData icone;
  final List<Color> cores;

  Filme({
    required this.titulo,
    required this.genero,
    required this.ano,
    required this.nota,
    required this.duracao,
    required this.descricao,
    required this.icone,
    required this.cores,
  });
}

class CineBoxHome extends StatefulWidget {
  const CineBoxHome({super.key});

  @override
  State<CineBoxHome> createState() => _CineBoxHomeState();
}

class _CineBoxHomeState extends State<CineBoxHome> {
  // ============================================================
  // WIDGETS NOVOS PESQUISADOS
  //
  // 1. SliverAppBar
  //    Barra superior que interage com a rolagem.
  //
  // 2. CustomScrollView
  //    Permite criar uma rolagem avançada.
  //
  // 3. SearchBar
  //    Campo de pesquisa moderno.
  //
  // 4. FilterChip
  //    Permite selecionar filtros.
  //
  // 5. PageView
  //    Cria um carrossel que pode ser deslizado.
  //
  // 6. AnimatedSwitcher
  //    Anima a troca de elementos.
  //
  // 7. ExpansionTile
  //    Permite expandir e esconder informações.
  //
  // 8. NavigationBar
  //    Cria uma navegação inferior moderna.
  //
  // 9. DevicePreview
  //    Permite testar a interface em diferentes dispositivos.
  //
  // 10. LayoutBuilder
  //     Permite adaptar a interface ao tamanho da tela.
  // ============================================================

  final TextEditingController pesquisaController =
      TextEditingController();

  final PageController pageController = PageController(
    viewportFraction: 0.88,
  );

  int paginaAtual = 0;

  String filtro = 'Todos';

  String pesquisa = '';

  final Set<String> favoritos = {};

  final List<Filme> filmes = [
    Filme(
      titulo: 'Interestelar',
      genero: 'Ficção',
      ano: 2014,
      nota: 8.7,
      duracao: '2h 49min',
      descricao:
          'Uma equipe de astronautas viaja através de um buraco '
          'de minhoca em busca de um novo lar para a humanidade.',
      icone: Icons.rocket_launch,
      cores: [
        Colors.indigo,
        Colors.black,
      ],
    ),

    Filme(
      titulo: 'O Cavaleiro das Trevas',
      genero: 'Ação',
      ano: 2008,
      nota: 9.0,
      duracao: '2h 32min',
      descricao:
          'Batman enfrenta uma ameaça que coloca Gotham em perigo '
          'e precisa tomar decisões difíceis para proteger a cidade.',
      icone: Icons.shield,
      cores: [
        Colors.blueGrey,
        Colors.black,
      ],
    ),

    Filme(
      titulo: 'Divertida Mente',
      genero: 'Comédia',
      ano: 2015,
      nota: 8.1,
      duracao: '1h 35min',
      descricao:
          'Dentro da mente de uma garota, emoções trabalham juntas '
          'para lidar com as mudanças em sua vida.',
      icone: Icons.emoji_emotions,
      cores: [
        Colors.orange,
        Colors.pink,
      ],
    ),

    Filme(
      titulo: 'Duna',
      genero: 'Ficção',
      ano: 2021,
      nota: 8.0,
      duracao: '2h 35min',
      descricao:
          'Um jovem nobre precisa viajar para um planeta desértico '
          'e enfrentar uma grande disputa pelo futuro de sua família.',
      icone: Icons.landscape,
      cores: [
        Colors.deepOrange,
        Colors.brown,
      ],
    ),

    Filme(
      titulo: 'It: A Coisa',
      genero: 'Terror',
      ano: 2017,
      nota: 7.3,
      duracao: '2h 15min',
      descricao:
          'Um grupo de amigos precisa enfrentar uma criatura '
          'misteriosa que assombra sua cidade.',
      icone: Icons.visibility,
      cores: [
        Colors.red,
        Colors.black,
      ],
    ),
  ];

  List<Filme> get filmesFiltrados {
    return filmes.where((filme) {
      final correspondeFiltro =
          filtro == 'Todos' || filme.genero == filtro;

      final correspondePesquisa =
          filme.titulo.toLowerCase().contains(
                pesquisa.toLowerCase(),
              );

      return correspondeFiltro && correspondePesquisa;
    }).toList();
  }

  List<Filme> get filmesDestaque {
    return filmes.take(4).toList();
  }

  @override
  void dispose() {
    pesquisaController.dispose();
    pageController.dispose();
    super.dispose();
  }

  void alternarFavorito(String titulo) {
    setState(() {
      if (favoritos.contains(titulo)) {
        favoritos.remove(titulo);
      } else {
        favoritos.add(titulo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildConteudo(),

      bottomNavigationBar: NavigationBar(
        selectedIndex: paginaAtual,

        onDestinationSelected: (index) {
          setState(() {
            paginaAtual = index;
          });
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }

  Widget _buildConteudo() {
    if (paginaAtual == 1) {
      return _buildFavoritos();
    }

    return _buildInicio();
  }

  Widget _buildInicio() {
    return CustomScrollView(
      slivers: [

        SliverAppBar(
          expandedHeight: 180,
          pinned: true,
          stretch: true,
          backgroundColor: Colors.deepPurple,

          flexibleSpace: FlexibleSpaceBar(
            title: const Text(
              'CineBox',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple,
                    Colors.indigo,
                    Colors.black,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),

              child: const Center(
                child: Icon(
                  Icons.movie_filter,
                  size: 90,
                  color: Colors.white24,
                ),
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                const SizedBox(height: 8),

                // SEARCH BAR
                SearchBar(
                  controller: pesquisaController,

                  hintText:
                      'Pesquisar filmes...',

                  leading: const Icon(
                    Icons.search,
                  ),

                  trailing: [
                    if (pesquisa.isNotEmpty)
                      IconButton(
                        icon: const Icon(
                          Icons.clear,
                        ),

                        onPressed: () {
                          pesquisaController.clear();

                          setState(() {
                            pesquisa = '';
                          });
                        },
                      ),
                  ],

                  onChanged: (valor) {
                    setState(() {
                      pesquisa = valor;
                    });
                  },
                ),

                const SizedBox(height: 24),

                const Text(
                  'Gêneros',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                SingleChildScrollView(
                  scrollDirection:
                      Axis.horizontal,

                  child: Row(
                    children: [
                      _buildFiltro('Todos'),
                      _buildFiltro('Ação'),
                      _buildFiltro('Comédia'),
                      _buildFiltro('Terror'),
                      _buildFiltro('Ficção'),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                const Text(
                  'Em destaque',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 14),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: SizedBox(
            height: 310,

            child: PageView.builder(
              controller: pageController,

              itemCount:
                  filmesDestaque.length,

              onPageChanged: (index) {
                setState(() {});
              },

              itemBuilder:
                  (context, index) {
                final filme =
                    filmesDestaque[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 6,
                  ),

                  child:
                      _buildCardDestaque(filme),
                );
              },
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding:
                const EdgeInsets.fromLTRB(
              16,
              30,
              16,
              10,
            ),

            child: Text(
              '${filmesFiltrados.length} filmes encontrados',

              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 16,
              ),
            ),
          ),
        ),

        if (filmesFiltrados.isEmpty)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(40),

              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 70,
                      color: Colors.grey,
                    ),

                    SizedBox(height: 12),

                    Text(
                      'Nenhum filme encontrado.',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          SliverPadding(
            padding:
                const EdgeInsets.fromLTRB(
              16,
              0,
              16,
              30,
            ),

            sliver: SliverList(
              delegate:
                  SliverChildBuilderDelegate(
                (context, index) {
                  return _buildFilmeCard(
                    filmesFiltrados[index],
                  );
                },

                childCount:
                    filmesFiltrados.length,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFiltro(String nome) {
    return Padding(
      padding:
          const EdgeInsets.only(right: 8),

      child: FilterChip(
        label: Text(nome),

        selected: filtro == nome,

        onSelected: (selecionado) {
          setState(() {
            filtro = nome;
          });
        },
      ),
    );
  }

  Widget _buildCardDestaque(Filme filme) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final telaGrande =
            constraints.maxWidth > 600;

        return AnimatedContainer(
          duration:
              const Duration(milliseconds: 400),

          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(
              telaGrande ? 35 : 25,
            ),

            gradient: LinearGradient(
              colors: filme.cores,

              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),

            boxShadow: [
              BoxShadow(
                color: filme.cores.first
                    .withOpacity(0.3),

                blurRadius: 15,

                offset:
                    const Offset(0, 8),
              ),
            ],
          ),

          child: Stack(
            children: [
              Positioned(
                right: -30,
                bottom: -30,

                child: Icon(
                  filme.icone,

                  size:
                      telaGrande ? 220 : 180,

                  color:
                      Colors.white
                          .withOpacity(0.08),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.all(24),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  mainAxisAlignment:
                      MainAxisAlignment.end,

                  children: [
                    Icon(
                      filme.icone,

                      size: 55,

                      color: Colors.white,
                    ),

                    const Spacer(),

                    Text(
                      filme.titulo,

                      maxLines: 2,

                      overflow:
                          TextOverflow.ellipsis,

                      style: TextStyle(
                        fontSize:
                            telaGrande
                                ? 32
                                : 27,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),

                        const SizedBox(width: 5),

                        Text(
                          '${filme.nota}',

                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          width: 15,
                        ),

                        Text(filme.genero),

                        const SizedBox(
                          width: 15,
                        ),

                        Text('${filme.ano}'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilmeCard(Filme filme) {
    final favorito =
        favoritos.contains(filme.titulo);

    return Card(
      margin:
          const EdgeInsets.only(bottom: 14),

      child: Column(
        children: [
          ListTile(
            contentPadding:
                const EdgeInsets.all(12),

            leading: Container(
              width: 60,
              height: 60,

              decoration:
                  BoxDecoration(
                borderRadius:
                    BorderRadius.circular(15),

                gradient:
                    LinearGradient(
                  colors: filme.cores,
                ),
              ),

              child: Icon(
                filme.icone,
                color: Colors.white,
                size: 30,
              ),
            ),

            title: Text(
              filme.titulo,

              style:
                  const TextStyle(
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            subtitle: Padding(
              padding:
                  const EdgeInsets.only(
                top: 5,
              ),

              child: Text(
                '${filme.genero} • '
                '${filme.ano} • '
                '⭐ ${filme.nota}',
              ),
            ),

            trailing: IconButton(
              onPressed: () {
                alternarFavorito(
                  filme.titulo,
                );
              },

              icon: AnimatedSwitcher(
                duration:
                    const Duration(
                  milliseconds: 300,
                ),

                child: Icon(
                  favorito
                      ? Icons.favorite
                      : Icons.favorite_border,

                  key: ValueKey(favorito),

                  color: favorito
                      ? Colors.red
                      : Colors.grey,
                ),
              ),
            ),
          ),

          ExpansionTile(
            leading: const Icon(
              Icons.info_outline,
            ),

            title: const Text(
              'Informações',
            ),

            children: [
              Padding(
                padding:
                    const EdgeInsets.fromLTRB(
                  16,
                  0,
                  16,
                  16,
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      filme.descricao,

                      style: TextStyle(
                        color:
                            Colors.grey.shade400,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          size: 18,
                        ),

                        const SizedBox(width: 8),

                        Text(
                          'Ano: ${filme.ano}',
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Icon(
                          Icons.category,
                          size: 18,
                        ),

                        const SizedBox(width: 8),

                        Text(
                          'Gênero: '
                          '${filme.genero}',
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Icon(
                          Icons.timer,
                          size: 18,
                        ),

                        const SizedBox(width: 8),

                        Text(
                          'Duração: '
                          '${filme.duracao}',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritos() {
    final filmesFavoritos = filmes
        .where(
          (filme) =>
              favoritos.contains(
            filme.titulo,
          ),
        )
        .toList();

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          pinned: true,

          title: Text(
            '❤️ Meus favoritos',
          ),
        ),

        if (filmesFavoritos.isEmpty)
          const SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 15),

                  Text(
                    'Você ainda não favoritou '
                    'nenhum filme.',

                    textAlign:
                        TextAlign.center,

                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          SliverPadding(
            padding:
                const EdgeInsets.all(16),

            sliver: SliverList(
              delegate:
                  SliverChildBuilderDelegate(
                (context, index) {
                  return _buildFilmeCard(
                    filmesFavoritos[index],
                  );
                },

                childCount:
                    filmesFavoritos.length,
              ),
            ),
          ),
      ],
    );
  }
}