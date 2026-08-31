import 'dart:core';

abstract class Produto {
int id, _nivelForca;
String mestreCriador;

Produto(this.id, this.mestreCriador, int nivelForca) : _nivelForca = nivelForca;

int get nivelForca => _nivelForca;

set validarNivel(int valor) {
  if(valor < 1 || valor > 100) {
    throw Exception("Nível de força instável para um Holocron");
  }
  _nivelForca = valor;
}

void purificarEnergia() {
  _nivelForca -= 20;
}

Map<String, dynamic> toJson();
}

class Holocron extends Produto {
  String corCristal;

  Holocron(int id, int nivelForca, String mestreCriador, this.corCristal) : 
  super(id, nivelForca.toString(), int.parse(mestreCriador));

  @override
  Map<String, dynamic> toJson() {
    return {
    'id': id,
    'Mestre criador': mestreCriador,
    'nivel de força': nivelForca,
    'Cor do cristal': corCristal,
    };
  }
  }

