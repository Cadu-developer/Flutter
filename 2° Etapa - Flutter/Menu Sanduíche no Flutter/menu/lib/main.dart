import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MeuApp(),
    ),
  );
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game Explorer',

      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),

      home: const TelaInicio(),
    );
  }
}

class TelaInicio extends StatelessWidget {
  const TelaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Explorer'),
        centerTitle: true,
      ),

      // Menu lateral
      drawer: const MenuLateral(),

      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(
                Icons.sports_esports,
                size: 100,
              ),

              SizedBox(height: 16),

              Text(
                'Bem-vindo ao Game Explorer!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(
                'Explore jogos, descubra novas aventuras '
                'e organize seus conteúdos favoritos.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              SizedBox(height: 30),

              CardJogo(
                icone: Icons.explore,
                titulo: 'Explorar',
                descricao:
                    'Descubra novos jogos, mundos e personagens.',
              ),

              SizedBox(height: 12),

              CardJogo(
                icone: Icons.favorite,
                titulo: 'Favoritos',
                descricao:
                    'Organize os jogos que você mais gosta.',
              ),

              SizedBox(height: 12),

              CardJogo(
                icone: Icons.emoji_events,
                titulo: 'Conquistas',
                descricao:
                    'Acompanhe seus desafios e recompensas.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

  // Função para navegar para outra tela
  void abrirTela(
    BuildContext context,
    Widget tela,
  ) {
    // Fecha o Drawer primeiro
    Navigator.pop(context);

    // Abre a nova tela
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => tela,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primary,
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.sports_esports,
                      size: 45,
                      color: Colors.deepPurple,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Game Explorer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    'Explore novos mundos e aventuras!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  //INÍCIO
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Início'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  //PERFIL
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Perfil'),
                    onTap: () {
                      abrirTela(
                        context,
                        const TelaPerfil(),
                      );
                    },
                  ),

                  //FAVORITOS
                  ListTile(
                    leading: const Icon(Icons.favorite),
                    title: const Text('Favoritos'),
                    onTap: () {
                      abrirTela(
                        context,
                        const TelaFavoritos(),
                      );
                    },
                  ),

                  //CONQUISTAS
                  ListTile(
                    leading: const Icon(Icons.emoji_events),
                    title: const Text('Conquistas'),
                    onTap: () {
                      abrirTela(
                        context,
                        const TelaConquistas(),
                      );
                    },
                  ),
                ],
              ),
            ),

            const Divider(),

            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Game Explorer • 2026',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaPerfil extends StatelessWidget {
  const TelaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              child: Icon(
                Icons.person,
                size: 70,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Jogador Explorer',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Apaixonado por jogos e novas aventuras.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            // Pontuação
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.star,
                  size: 35,
                ),
                title: const Text(
                  'Pontuação',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Text(
                  '2.450 XP',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Jogos concluídos
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.videogame_asset,
                  size: 35,
                ),
                title: const Text(
                  'Jogos concluídos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Text(
                  '18',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Conquistas
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.emoji_events,
                  size: 35,
                ),
                title: const Text(
                  'Conquistas',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Text(
                  '12',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaFavoritos extends StatelessWidget {
  const TelaFavoritos({super.key});

  @override
  Widget build(BuildContext context) {
    final jogos = [
      {
        'nome': 'Minecraft',
        'categoria': 'Aventura',
        'icone': Icons.landscape,
      },
      {
        'nome': 'GTA V',
        'categoria': 'Ação',
        'icone': Icons.directions_car,
      },
      {
        'nome': 'Rayman Origins',
        'categoria': 'Plataforma',
        'icone': Icons.sports_esports,
      },
      {
        'nome': 'Space Engine',
        'categoria': 'Simulação',
        'icone': Icons.public,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Favoritos'),
        centerTitle: true,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: jogos.length,
        itemBuilder: (context, index) {
          final jogo = jogos[index];

          return Card(
            margin: const EdgeInsets.only(
              bottom: 12,
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),

              leading: CircleAvatar(
                radius: 28,
                child: Icon(
                  jogo['icone'] as IconData,
                  size: 30,
                ),
              ),

              title: Text(
                jogo['nome'] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),

              subtitle: Text(
                jogo['categoria'] as String,
              ),

              trailing: IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}

class TelaConquistas extends StatelessWidget {
  const TelaConquistas({super.key});

  @override
  Widget build(BuildContext context) {
    final conquistas = [
      {
        'titulo': 'Primeira aventura',
        'descricao': 'Complete seu primeiro jogo.',
        'icone': Icons.flag,
      },
      {
        'titulo': 'Explorador',
        'descricao': 'Explore 10 mundos diferentes.',
        'icone': Icons.explore,
      },
      {
        'titulo': 'Mestre dos jogos',
        'descricao': 'Complete 10 jogos.',
        'icone': Icons.emoji_events,
      },
      {
        'titulo': 'Colecionador',
        'descricao': 'Adicione 5 jogos aos favoritos.',
        'icone': Icons.collections_bookmark,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Conquistas'),
        centerTitle: true,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: conquistas.length,
        itemBuilder: (context, index) {
          final conquista = conquistas[index];

          return Card(
            margin: const EdgeInsets.only(
              bottom: 12,
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),

              leading: CircleAvatar(
                radius: 28,
                child: Icon(
                  conquista['icone'] as IconData,
                  size: 30,
                ),
              ),

              title: Text(
                conquista['titulo'] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),

              subtitle: Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                ),
                child: Text(
                  conquista['descricao'] as String,
                ),
              ),

              trailing: const Icon(
                Icons.check_circle,
              ),
            ),
          );
        },
      ),
    );
  }
}

class CardJogo extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String descricao;

  const CardJogo({
    super.key,
    required this.icone,
    required this.titulo,
    required this.descricao,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Icon(
              icone,
              size: 50,
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(descricao),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}