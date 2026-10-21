abstract class Conta {
 String titular;
 double _saldo = 0;


 Conta(this.titular);


 double get saldoAtual => _saldo;


 set atualizarSaldo(double valor) => _saldo = valor;


 void depositar(double valor);
 void sacar(double valor);

 Map<String, dynamic> toJson();
}


class ContaCorrente extends Conta {
 ContaCorrente(String nome) : super(nome);


 @override
 void depositar(double valor) {
   if (valor <= 0) throw Exception('Depósito inválido!');
   atualizarSaldo = saldoAtual + valor;
   print('✅ Sucesso: R\$ $valor na conta de $titular.');
 }


 @override
 void sacar(double valor) {
   if (valor <= 0 || valor > saldoAtual)
     throw Exception('Saldo insuficiente!');
   atualizarSaldo = saldoAtual - valor;
 }

 @override
 Map<String, dynamic> toJson(){
  return {'titular': titular, 'saldo': saldoAtual};
 }

}



