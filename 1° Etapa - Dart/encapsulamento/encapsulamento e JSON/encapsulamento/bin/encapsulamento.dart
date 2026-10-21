import 'dart:io';
import 'dart:convert';
import 'package:encapsulamento/encapsulamento.dart';


void salvar(List<Conta> conta) {
 final arquivo = File('./dados.json');
List<Map< String, dynamic>> listaParaSalvar = conta
     .map((dados) => dados.toJson())
     .toList();
 arquivo.writeAsStringSync(jsonEncode(listaParaSalvar));
}


void main() {
 List<Conta> bancoDeDados = [];


 final arquivo = File('./dados.json');


 if (arquivo.existsSync()) {
   List<dynamic> dados = jsonDecode(arquivo.readAsStringSync());
   for (var item in dados) {
     var contaAtual = ContaCorrente(item['titular']);
     contaAtual.atualizarSaldo = item['saldo'];
     bancoDeDados.add(contaAtual);
   }
 }


 while (true) {
   print('=== BANCO ===');


   for (var nomeAtual in bancoDeDados) {
     print(
       '👤 ${nomeAtual.titular} | Saldo: R\$ ${nomeAtual.saldoAtual.toStringAsFixed(2)}',
     );
   }
   print('-------------------------------------');
   print(
     '[1] Depositar | [2] Sacar | [3] Nova Conta | [4] Deletar | [5] Sair',
   );
   stdout.write('Escolha: ');


   String? opcao = stdin.readLineSync();
   if (opcao == '5') break;


   try {

    // ATUALIZA - UPDATE 
     if (opcao == '1' || opcao == '2') {
       stdout.write('Nome do Titular: ');
       String nome = stdin.readLineSync()!;


       stdout.write('Valor: ');
       double valor = double.parse(stdin.readLineSync()!);


       bool encontrouTitular = false;


       for (var nomeAtual in bancoDeDados) {
         if (nomeAtual.titular == nome) {
           encontrouTitular = true;
           if (opcao == '1') nomeAtual.depositar(valor);
           if (opcao == '2') nomeAtual.sacar(valor);
           break;
         }
       }


       if (encontrouTitular == false) {
         throw Exception('Titular "$nome" não encontrado no banco de dados!');
       }

      // create
     } else if (opcao == '3') {
       stdout.write('Nome do Novo Titular: ');
       String nome = stdin.readLineSync()!;
       bancoDeDados.add(ContaCorrente(nome));
       print('✅ Conta de $nome criada com sucesso!');


     } else if (opcao == '4') {
       stdout.write('Nome do Titular para EXCLUIR: ');
       String nome = stdin.readLineSync()!;


       bancoDeDados.removeWhere((nomeAtual) => nomeAtual.titular == nome);
       print('🗑️ Conta de $nome removida do sistema!');
     }


     salvar(bancoDeDados);
   } catch (e) {
     print('\n⚠️ ERRO: ${e.toString().replaceAll('Exception: ', '')}');
     stdout.write('Pressione Enter para continuar...');
     stdin.readLineSync();
   }
 }
}



