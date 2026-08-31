import 'video.dart';

class Filme extends Video {
  int duracaoMinutos;

  Filme(String titulo, this.duracaoMinutos) : super(titulo);
}
