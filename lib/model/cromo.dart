class Cromo {
  int? index;
  String? descricao;
  String? siglaSelecao;
  bool? possuiRepetidas;
  bool? ativo;

  Cromo(
      {required this.index,
      required this.descricao,
      required this.siglaSelecao,
      required this.possuiRepetidas,
      required this.ativo});

  Cromo.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    descricao = json['descricao'];
    siglaSelecao = json['siglaSelecao'];
    possuiRepetidas = json['possuiRepetidas'];
    ativo = json['ativo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = index;
    data['descricao'] = descricao;
    data['siglaSelecao'] = siglaSelecao;
    data['possuiRepetidas'] = possuiRepetidas;
    data['ativo'] = ativo;
    return data;
  }
}
