abstract class Pet {
  int id;
  String nome;
  double _peso;

  Pet(this.id, this.nome, double peso) : _peso = peso;

  double get peso => _peso;

  set peso(double valor) {
    if (valor <= 0) {
      throw Exception("Peso inválido");
    }
    _peso = valor;
  }

  void engordar(double ganho) {
    peso = _peso + ganho;
  }
}

class Cachorro extends Pet {
  String raca;

  Cachorro(int id, String nome, double peso, this.raca)
      : super(id, nome, peso);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'peso': peso,
      'raca': raca,
    };
  }

  factory Cachorro.fromJson(Map<String, dynamic> json) {
    return Cachorro(
      json['id'],
      json['nome'],
      json['peso'],
      json['raca'],
    );
  }
}