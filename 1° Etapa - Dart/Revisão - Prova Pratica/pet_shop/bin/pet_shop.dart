import 'dart:convert';
import 'dart:io';
import '../lib/pet_shop.dart';

void main() async {
  final file = File('petshop.json');
  List<Cachorro> pets = [];

  // Leitura
  if (await file.exists()) {
    String conteudo = await file.readAsString();
    List dados = jsonDecode(conteudo);
    pets = dados.map((e) => Cachorro.fromJson(e)).toList();
  }

  print("1 - Engordar pet");
  print("2 - Remover pet");
  int opcao = int.parse(stdin.readLineSync()!);

  if (opcao == 1) {
    print("Digite o ID:");
    int id = int.parse(stdin.readLineSync()!);

    var pet = pets.firstWhere((p) => p.id == id, orElse: () => throw Exception("Pet não encontrado"));

    print("Digite o ganho de peso:");
    double ganho = double.parse(stdin.readLineSync()!);

    pet.engordar(ganho);

  } else if (opcao == 2) {
    print("Digite o ID para remover:");
    int id = int.parse(stdin.readLineSync()!);

    pets.removeWhere((p) => p.id == id);
  }

  // Média de peso
  if (pets.isNotEmpty) {
    double media = pets.map((p) => p.peso).reduce((a, b) => a + b) / pets.length;
    print("Média de peso: $media");
  }

  // Salvamento
  await file.writeAsString(jsonEncode(pets.map((p) => p.toJson()).toList()));
}