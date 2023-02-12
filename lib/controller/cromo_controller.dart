import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stickers/model/cromo.dart';
import 'package:stickers/model/selecao.dart';
import '../model/registro.dart';

class CromoCrontroller {
  static const String SELECOES = "SELECOES_V6";

  static List<Registro> _listarFonte() {
    List<Registro> registros = [
      Registro(
          index: "FWC",
          pais: "FIFA",
          qtde: 30,
          pathBandeira: "images/fifa.png"),
      Registro(
          index: "QAT",
          pais: "QUATAR",
          qtde: 20,
          pathBandeira: "images/qatar_flag-png-small.png"),
      Registro(
          index: "ECU",
          pais: "EQUADOR",
          qtde: 20,
          pathBandeira: "images/ecuador_flag-png-small.png"),
      Registro(
          index: "SEN",
          pais: "SENEGAL",
          qtde: 20,
          pathBandeira: "images/senegal_flag-png-small.png"),
      Registro(
          index: "NED",
          pais: "HOLANDA",
          qtde: 20,
          pathBandeira: "images/netherlands_flag-png-small.png"),
      Registro(
          index: "ENG",
          pais: "INGLATERRA",
          qtde: 20,
          pathBandeira: "images/england_flag-png-small.png"),
      Registro(
          index: "IRN",
          pais: "IRÃ",
          qtde: 20,
          pathBandeira: "images/iran_flag-png-small.png"),
      Registro(
          index: "USA",
          pais: "ESTADOS UNIDOS",
          qtde: 20,
          pathBandeira: "images/united-states-of-america_flag-png-small.png"),
      Registro(
          index: "WAL",
          pais: "PAÍS DE GALES",
          qtde: 20,
          pathBandeira: "images/wales_flag-png-small.png"),
      Registro(
          index: "ARG",
          pais: "ARGENTINA",
          qtde: 20,
          pathBandeira: "images/argentina_flag-png-small.png"),
      Registro(
          index: "KSA",
          pais: "ARÁBIA SAUDITA",
          qtde: 20,
          pathBandeira: "images/saudi-arabia_flag-png-small.png"),
      Registro(
          index: "MEX",
          pais: "MÉXICO",
          qtde: 20,
          pathBandeira: "images/mexico_flag-png-small.png"),
      Registro(
          index: "POL",
          pais: "POLÔNIA",
          qtde: 20,
          pathBandeira: "images/poland_flag-png-small.png"),
      Registro(
          index: "FRA",
          pais: "FRANÇA",
          qtde: 20,
          pathBandeira: "images/france_flag-png-small.png"),
      Registro(
          index: "AUS",
          pais: "ÁUSTRÁLIA",
          qtde: 20,
          pathBandeira: "images/australia_flag-png-small.png"),
      Registro(
          index: "DEN",
          pais: "DINAMARCA",
          qtde: 20,
          pathBandeira: "images/denmark_flag-png-small.png"),
      Registro(
          index: "TUN",
          pais: "TUNÍSIA",
          qtde: 20,
          pathBandeira: "images/tunisia_flag-png-small.png"),
      Registro(
          index: "ESP",
          pais: "ESPANHA",
          qtde: 20,
          pathBandeira: "images/spain_flag-png-small.png"),
      Registro(
          index: "CRC",
          pais: "COSTA RICA",
          qtde: 20,
          pathBandeira: "images/costa-rica_flag-png-small.png"),
      Registro(
          index: "GER",
          pais: "ALEMANHA",
          qtde: 20,
          pathBandeira: "images/germany_flag-png-small.png"),
      Registro(
          index: "JPN",
          pais: "JAPÃO",
          qtde: 20,
          pathBandeira: "images/japan_flag-png-small.png"),
      Registro(
          index: "BEL",
          pais: "BÉLGICA",
          qtde: 20,
          pathBandeira: "images/belgium_flag-png-small.png"),
      Registro(
          index: "CAN",
          pais: "CANADÁ",
          qtde: 20,
          pathBandeira: "images/canada_flag-png-small.png"),
      Registro(
          index: "MAR",
          pais: "MARROCOS",
          qtde: 20,
          pathBandeira: "images/morocco_flag-png-small.png"),
      Registro(
          index: "CRO",
          pais: "CROÁCIA",
          qtde: 20,
          pathBandeira: "images/croatia_flag-png-small.png"),
      Registro(
          index: "BRA",
          pais: "BRASIL",
          qtde: 20,
          pathBandeira: "images/brazil_flag-png-small.png"),
      Registro(
          index: "SRB",
          pais: "SÉRVIA",
          qtde: 20,
          pathBandeira: "images/serbia_flag-png-small.png"),
      Registro(
          index: "SUI",
          pais: "SUIÇA",
          qtde: 20,
          pathBandeira: "images/switzerland_flag-png-small.png"),
      Registro(
          index: "CMR",
          pais: "CAMARÕES",
          qtde: 20,
          pathBandeira: "images/cameroon_flag-png-small.png"),
      Registro(
          index: "POR",
          pais: "PORTUGAL",
          qtde: 20,
          pathBandeira: "images/portugal_flag-png-small.png"),
      Registro(
          index: "GHA",
          pais: "GANA",
          qtde: 20,
          pathBandeira: "images/ghana_flag-png-small.png"),
      Registro(
          index: "URU",
          pais: "URUGUAI",
          qtde: 20,
          pathBandeira: "images/uruguay_flag-png-small.png"),
      Registro(
          index: "KOR",
          pais: "CORÉIA",
          qtde: 20,
          pathBandeira: "images/south-korea_flag-png-small.png"),
      Registro(
        index: "C",
        pais: "COCA-COLA",
        qtde: 8,
        pathBandeira: "images/coca-cola-logo.png",
      )
    ];

    return registros;
  }

  static int retornarCromosAtivos(List<Cromo> cromos) {
    int ativos = 0;
    cromos.forEach((Cromo cromo) {
      if (cromo.ativo ?? false) {
        ativos++;
      }
    });
    return ativos;
  }

  static List<Selecao> listarSelecoes() {
    List<Selecao> lista = [];
    Selecao selecao;

    List<Registro> registros = _listarFonte();

    registros.forEach((reg) {
      selecao = Selecao(
          index: reg.index,
          pais: reg.pais,
          bandeira: reg.pathBandeira,
          qtdeCromos: reg.qtde);

      lista.add(selecao);
    });

    return lista;
  }

  static Selecao buscarSelecao(final String id) {
    List<Selecao> lista = listarSelecoes();
    late Selecao selecao;
    for (int i = 0; i < lista.length; i++) {
      if (lista[i].index == id) {
        selecao = lista[i];
        break;
      }
    }

    return selecao;
  }

  static List<Cromo> _gerarCromos(Selecao selecao) {
    List<Cromo> lista = [];
    Cromo cromo;
    int qtde = selecao.qtdeCromos;
    String index = selecao.index ?? '';

    if (index.compareTo('FWC') == 0) {
      for (int i = 0; i < qtde; i++) {
        if (i == 0) {
          cromo = Cromo(
              index: i,
              descricao: '00',
              possuiRepetidas: false,
              ativo: false,
              siglaSelecao: selecao.index);
          lista.add(cromo);
        } else {
          cromo = Cromo(
              index: i,
              descricao: (index.length < 3
                  ? index + i.toString()
                  : index + '\n' + i.toString()),
              possuiRepetidas: false,
              ativo: false,
              siglaSelecao: selecao.index);
          lista.add(cromo);
        }
      }
    } else {
      for (int i = 1; i <= qtde; i++) {
        cromo = Cromo(
            index: i,
            descricao: (index.length < 3
                ? index + i.toString()
                : index + '\n' + i.toString()),
            possuiRepetidas: false,
            ativo: false,
            siglaSelecao: selecao.index);
        lista.add(cromo);
      }
    }

    return lista;
  }

  static List<Cromo> _recuperarCromosSalvos(
      Selecao selecao, String? jsonCromos) {
    List<Cromo> lista = [];
    var jsonLista = jsonDecode(jsonCromos ?? '');

    for (var data in jsonLista) {
      lista.add(Cromo(
          index: data['index'],
          descricao: data['descricao'],
          siglaSelecao: data['siglaSelecao'],
          possuiRepetidas: data['possuiRepetidas'],
          ativo: data['ativo']));
    }

    return lista;
  }

  static Future<List<Cromo>> listarCromos(Selecao selecao) async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonCromos = prefs.getString(selecao.index ?? '');

    if (null != jsonCromos) {
      return _recuperarCromosSalvos(selecao, jsonCromos);
    } else {
      return _gerarCromos(selecao);
    }
  }

  static Future<void> salvarSelecoes(List<Selecao> lista) async {
    String jsonLista = jsonEncode(lista);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SELECOES, jsonLista);
  }

  static Future<void> salvarCromos(List<Cromo> lista, String sigla) async {
    String jsonLista = jsonEncode(lista);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(sigla, jsonLista);
  }
}
