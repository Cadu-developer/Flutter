import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pokemon_provider.dart';
import 'tela_detalhes_pokemon.dart';

class TelaPokemon extends StatefulWidget {
  const TelaPokemon({
    super.key,
  });

  @override
  State<TelaPokemon> createState() => _TelaPokemonState();
}

class _TelaPokemonState extends State<TelaPokemon> {
  final TextEditingController _nomeController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  void _pesquisar() {
    context.read<PokemonProvider>().pesquisarPorNome(
          _nomeController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PokemonProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokédex',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _pesquisar(),
              decoration: InputDecoration(
                labelText: 'Nome do Pokémon',
                hintText: 'Ex.: pikachu',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _nomeController.clear();
                  },
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _pesquisar,
                    child: const Text(
                      'Pesquisar',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      context
                          .read<PokemonProvider>()
                          .carregarAleatorio();
                    },
                    icon: const Icon(Icons.shuffle),
                    label: const Text(
                      'Aleatório',
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  context.read<PokemonProvider>().carregarPokemons();
                },
                child: const Text(
                  'Ver lista de Pokémon',
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            if (provider.carregando)
              const Padding(
                padding: EdgeInsets.all(12),
                child: CircularProgressIndicator(),
              ),

            if (!provider.carregando && provider.erro != null)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  provider.erro!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

            if (!provider.carregando && provider.erro == null)
              Expanded(
                child: provider.pokemons.isEmpty
                    ? const Center(
                        child: Text(
                          'Pesquise um Pokémon ou carregue a lista.',
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        itemCount: provider.pokemons.length,
                        itemBuilder: (context, index) {
                          final pokemon = provider.pokemons[index];

                          return Card(
                            child: ListTile(
                              leading: Image.network(
                                pokemon['imagem'],
                                width: 60,
                                errorBuilder: (
                                  context,
                                  error,
                                  stackTrace,
                                ) {
                                  return const Icon(
                                    Icons.catching_pokemon,
                                    size: 40,
                                  );
                                },
                              ),
                              title: Text(
                                pokemon['nome']
                                    .toString()
                                    .toUpperCase(),
                              ),
                              subtitle: Text(
                                'Tipo: ${pokemon['tipo'] ?? (pokemon['tipos'] as List?)?.join(', ') ?? 'N/A'}',
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return TelaDetalhesPokemon(
                                        idPokemon: pokemon['id'],
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
              ),
          ],
        ),
      ),
    );
  }
}
