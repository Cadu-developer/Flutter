enum TipoAtividade { oficina, palestra, exposicao, competicao, apresentacaoCultural }

extension TipoAtividadeExt on TipoAtividade {
  String get nome {
    switch (this) {
      case TipoAtividade.oficina: return 'Oficina';
      case TipoAtividade.palestra: return 'Palestra';
      case TipoAtividade.exposicao: return 'Exposição';
      case TipoAtividade.competicao: return 'Competição';
      case TipoAtividade.apresentacaoCultural: return 'Apresentação Cultural';
    }
  }
}

class AtividadeModel {
  String nome;
  String responsavel;
  String local;
  TipoAtividade? tipo;
  double duracaoMinutos; 
  double participantes; 

  bool projetor;
  bool computadores;
  bool sistemaSom;
  bool internet;
  bool mesasAdicionais;

  AtividadeModel({
    this.nome = '',
    this.responsavel = '',
    this.local = '',
    this.tipo,
    this.duracaoMinutos = 60,
    this.participantes = 20,
    this.projetor = false,
    this.computadores = false,
    this.sistemaSom = false,
    this.internet = false,
    this.mesasAdicionais = false,
  });

  //Classificação de Capacidade
  String get classificacao {
    if (participantes <= 20) return 'Atividade pequena';
    if (participantes <= 50) return 'Atividade média';
    return 'Atividade grande';
  }

  //Formatação de Duração
  String get duracaoFormatada {
    int total = duracaoMinutos.round();
    int horas = total ~/ 60;
    int minutos = total % 60;

    if (horas == 0) return '$minutos minutos';
    if (minutos == 0) return horas == 1 ? '1 hora' : '$horas horas';

    String strHora = horas == 1 ? '1 hora' : '$horas horas';
    String strMinuto = '$minutos minutos';
    return '$strHora e $strMinuto';
  }

  //Quantidade de recursos ativados
  int get quantidadeRecursosAtivos {
    int qtd = 0;
    if (projetor) qtd++;
    if (computadores) qtd++;
    if (sistemaSom) qtd++;
    if (internet) qtd++;
    if (mesasAdicionais) qtd++;
    return qtd;
  }

  //Etapas Concluídas
  int get etapasConcluidas {
    int concluidas = 0;
    if (nome.trim().isNotEmpty) concluidas++;
    if (responsavel.trim().isNotEmpty) concluidas++;
    if (local.trim().isNotEmpty) concluidas++;
    if (tipo != null) concluidas++;
    if (duracaoMinutos >= 15 && duracaoMinutos <= 180) concluidas++;
    if (participantes >= 5 && participantes <= 100) concluidas++;
    // Pelo menos um recurso foi ativado ou configurado/analisado
    if (quantidadeRecursosAtivos > 0 || tipo == TipoAtividade.palestra) concluidas++;
    return concluidas;
  }

  //Verificação de Erros
  String? validarIncompleto() {
    if (nome.trim().isEmpty) return 'Informe o nome da atividade.';
    if (responsavel.trim().isEmpty) return 'Informe o nome do responsável.';
    if (local.trim().isEmpty) return 'Informe a sala ou local.';
    if (tipo == null) return 'Selecione o tipo de atividade.';
    return null;
  }

//Avisos e alertas
  List<String> obterAlertas() {
    List<String> alertas = [];

    if (computadores && participantes > 30) {
      alertas.add('Verifique se o laboratório possui computadores suficientes.');
    }
    if (tipo == TipoAtividade.competicao && duracaoMinutos < 60) {
      alertas.add('Atenção: Competições devem ter duração mínima de 60 minutos.');
    }
    if (tipo == TipoAtividade.apresentacaoCultural && !sistemaSom) {
      alertas.add('Recomendação: Apresentações culturais normalmente precisam de sistema de som.');
    }
    if (participantes > 50 && !mesasAdicionais) {
      alertas.add('Atividades grandes costumam necessitar de mesas adicionais.');
    }

    return alertas;
  }

  void resetar() {
    nome = '';
    responsavel = '';
    local = '';
    tipo = null;
    duracaoMinutos = 60;
    participantes = 20;
    projetor = false;
    computadores = false;
    sistemaSom = false;
    internet = false;
    mesasAdicionais = false;
  }
}