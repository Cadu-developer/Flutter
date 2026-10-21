import 'package:aluno_12400432/aluno_12400432.dart' as mensagens;

abstract class Pai_Mensagem{
    String texto;
    Pai_Mensagem(this.texto);

}

class FilhaSMS extends Pai_Mensagem {
    FilhaSMS(String texto) : super(texto);
}

   @override
   void main (){
        print("Oi");
    }