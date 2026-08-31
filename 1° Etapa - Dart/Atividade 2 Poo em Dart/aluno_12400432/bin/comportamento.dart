import 'package:aluno_12400432/aluno_12400432.dart' as comportamento;

class Mensagem{
    void enviar (){
        print("Enviando mensagem...");
    }
}

class Sms extends Mensagem{

@override
      void enviar (){
        print("Enviando via SMS pelo celular...");
    }

}

class Email extends Mensagem{

    void enviar (){
        print("Enviando via servidor de e-mail...");
    }
}

void main () {

  Mensagem msg = Mensagem();
  Sms sms = Sms();
  Email email = Email();

  msg.enviar();
  sms.enviar();
  email.enviar();
}