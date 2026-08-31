
abstract class Pagamento {
    final double valor;
    Pagamento(this.valor);

    void processar();
}

class PagamentoCartao extends Pagamento {
    PagamentoCartao(double valor) : super(valor);

    @override
    void processar() {
        print("Validando senha e processando R\$ $valor no Cartão...");
    }

}

class PagamentoPix extends Pagamento {
    PagamentoPix(double valor) : super(valor);

       @override
    void processar() {
        print("Gerando QR Code para Pix de R\$ $valor...");
    }
}

void main() {
    PagamentoCartao meuCartao = PagamentoCartao(150.0);
    meuCartao.processar();
    PagamentoPix meuPix = PagamentoPix(50.0);
    meuPix.processar();
}