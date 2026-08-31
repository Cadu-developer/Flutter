import 'package:flutter/material.dart';

import '../widgets/botao_player.dart';
import 'tela_perfil.dart';

class TelaPlayer extends StatefulWidget {
  const TelaPlayer({super.key});

  @override
  State<TelaPlayer> createState() => _TelaPlayerState();
}

class _TelaPlayerState extends State<TelaPlayer> {
  final List<Map<String, String>> musicas = [
    {
      'nome': 'I\'m So Sorry',
      'artista': 'Imagine Dragons',
      'album': 'Smoke + Mirrors',
      'duracao': '3:50',
      'imagem': 'assets/Smoke_and_Mirrors_album_cover.jpeg',
    },
    {
      'nome': 'Sunflower',
      'artista': 'Post Malone e Swae Lee',
      'album': 'Spider-Man: Into the Spider-Verse '
          '(Soundtrack From & Inspired by the Motion Picture)',
      'duracao': '2:38',
      'imagem': 'assets/images.jpeg',
    },
    {
      'nome': 'The Last of Us Part II',
      'artista': 'Gustavo Santaolalla',
      'album': 'The Last of Us Part II (Original Soundtrack)',
      'duracao': '2:52',
      'imagem': 'assets/thelastofus.jpeg',
    },
  ];

  int indiceAtual = 0;
  bool tocando = false;
  int volume = 5;

  void playPause() {
    setState(() {
      tocando = !tocando;
    });
  }

  void proximaMusica() {
    setState(() {
      indiceAtual++;

      if (indiceAtual >= musicas.length) {
        indiceAtual = 0;
      }

      tocando = false;
    });
  }

  void musicaAnterior() {
    setState(() {
      indiceAtual--;

      if (indiceAtual < 0) {
        indiceAtual = musicas.length - 1;
      }

      tocando = false;
    });
  }

  void aumentarVolume() {
    if (volume < 10) {
      setState(() {
        volume++;
      });
    }
  }

  void diminuirVolume() {
    if (volume > 0) {
      setState(() {
        volume--;
      });
    }
  }

  void abrirInformacoes() {
    final musica = musicas[indiceAtual];

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sobre a música',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                musica['nome']!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('Artista: ${musica['artista']}'),
              Text('Álbum: ${musica['album']}'),
              Text('Duração: ${musica['duracao']}'),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Fechar'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final musica = musicas[indiceAtual];

    final larguraTela = MediaQuery.of(context).size.width;

    final bool telaGrande = larguraTela >= 700;

    final double tamanhoCapa = telaGrande ? 380 : 280;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyMusic'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const TelaPerfil();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.account_circle_outlined,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 400,
                  ),
                  width: tocando ? tamanhoCapa : tamanhoCapa - 15,
                  height: tocando ? tamanhoCapa : tamanhoCapa - 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 25,
                        offset: Offset(0, 12),
                        color: Colors.black45,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      musica['imagem']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  musica['nome']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  musica['artista']!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(height: 20),
                LinearProgressIndicator(
                  value: tocando ? 0.55 : 0.25,
                  minHeight: 5,
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tocando ? '02:20' : '01:00',
                    ),
                    Text(
                      musica['duracao']!,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BotaoPlayer(
                      icone: Icons.skip_previous,
                      aoClicar: musicaAnterior,
                    ),
                    const SizedBox(width: 25),
                    BotaoPlayer(
                      icone: tocando ? Icons.pause : Icons.play_arrow,
                      aoClicar: playPause,
                      principal: true,
                    ),
                    const SizedBox(width: 25),
                    BotaoPlayer(
                      icone: Icons.skip_next,
                      aoClicar: proximaMusica,
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: diminuirVolume,
                      icon: const Icon(
                        Icons.volume_down,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      volume == 0 ? '🔇 Sem som' : 'Volume: $volume',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 15),
                    IconButton(
                      onPressed: aumentarVolume,
                      icon: const Icon(
                        Icons.volume_up,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                OutlinedButton.icon(
                  onPressed: abrirInformacoes,
                  icon: const Icon(
                    Icons.info_outline,
                  ),
                  label: const Text(
                    'Mais informações',
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
