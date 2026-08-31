import 'package:video/video.dart' as video;

class Video {
  String titulo;
  int _classificacao = 0;

  Video(this.titulo);

  int get classificacao => _classificacao;

  set classificacao(int valor) {
    if ([0, 10, 12, 14, 16, 18].contains(valor)) {
      _classificacao = valor;
    } 
    
    else {
      throw Exception("Classificação inválida!");
    }
  }
}

void main(List<String> arguments) {
  print('Hello world: ${video.calculate()}!');
}
