class Selecao {
  String? index;
  String? pais;
  String? bandeira;
  int qtdeCromos = 0;
  int _cromosAtivos = 0;

  Selecao({this.index, this.pais, this.bandeira, required this.qtdeCromos});

  Selecao.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    pais = json['pais'];
    bandeira = json['bandeira'];
    qtdeCromos = json['qtdeCromos'];
  }

  int get cromosAtivos => _cromosAtivos;
  set setCromosAtivos(int value) => _cromosAtivos = value;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = index;
    data['pais'] = pais;
    data['bandeira'] = bandeira;
    data['qtdeCromos'] = qtdeCromos;
    return data;
  }
}
