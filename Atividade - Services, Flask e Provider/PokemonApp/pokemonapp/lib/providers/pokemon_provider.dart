import 'package:flutter/material.dart';
import '../services/pokemon_service.dart';

class PokemonProvider extends ChangeNotifier {
  List<dynamic> pokemons = [];

  Map<String, dynamic>? pokemonSelecionado;

  bool carregando = false;

  String? erro;

  Future<void> carregarPokemons() async {
    carregando = true;
    erro = null;

    notifyListeners();

    try {
      pokemons = await PokemonService.buscarPokemons();
    } 

    catch (e) {
      erro = 'Não foi possível carregar os Pokémon.';
    }

    carregando = false;

    notifyListeners();
  }

  Future<void> carregarDetalhes(
    int id,
  ) async {
    carregando = true;
    erro = null;
    pokemonSelecionado = null;

    notifyListeners();

    try {
      pokemonSelecionado = await PokemonService.buscarDetalhes(
        id,
      );
    }
    
    catch (e) {
      erro = 'Pokémon não encontrado.';
    }

    carregando = false;

    notifyListeners();
  }

  Future<void> pesquisarPorNome(String nome) async {
    if (nome.trim().isEmpty) {
      erro = 'Digite o nome de um Pokémon.';
      
      notifyListeners();

      return;
    }

    carregando = true;
    erro = null;
    pokemonSelecionado = null;

    notifyListeners();

    try {
      pokemonSelecionado = await PokemonService.buscarPorNome(nome);
      pokemons = [pokemonSelecionado!];
    } 

    catch (e) {
      erro = 'Pokémon "$nome" não encontrado.';
      pokemons = [];
    }

    carregando = false;

    notifyListeners();
  }

  Future<void> carregarAleatorio() async {
    carregando = true;
    erro = null;
    pokemonSelecionado = null;

    notifyListeners();

    try {
      pokemonSelecionado = await PokemonService.buscarAleatorio();
      pokemons = [pokemonSelecionado!];
    } 

    catch (e) {
      erro = 'Não foi possível buscar um Pokémon aleatório.';
    }

    carregando = false;

    notifyListeners();
  }
}
