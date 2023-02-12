import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stickers/controller/cromo_controller.dart';
import 'package:stickers/model/cromo.dart';

import '../model/selecao.dart';

class CromoPage extends StatefulWidget {
  final String title;
  final Selecao selecao;

  CromoPage({
    Key? key,
    required this.title,
    required this.selecao,
  }) : super(key: key);

  @override
  State<CromoPage> createState() => _CromoPageState();
}

class _CromoPageState extends State<CromoPage> {
  List<Cromo> cromos = [];

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    CromoCrontroller.listarCromos(widget.selecao).then((lista) {
      setState(() {
        if (lista.isNotEmpty) {
          cromos.addAll(lista);
        }
        _atualizarSelecao();
      });
    });
  }

  void _salvarCromos(String? sigla) {
    CromoCrontroller.salvarCromos(cromos, sigla!);
  }

  void _atualizarSelecao() {
    widget.selecao.setCromosAtivos =
        CromoCrontroller.retornarCromosAtivos(cromos);
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Informações"),
          content: const Text(
              "Este aplicativo foi desenvolvido por Carlos Eduardo (carlos.hardrock@gmail.com) para uso gratuito, sendo proibido a sua comercialização. \nCaso queira contribuir com o projeto, envie um PIX para o fone: (41)999502834"),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
                fixedSize: Size.fromWidth(100),
                padding: EdgeInsets.all(10),
              ),
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            )
          ],
          elevation: 24.0,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, 'selecaoPage');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: const Icon(Icons.sports_soccer_sharp),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'selecaoPage');
              },
              icon: const Icon(Icons.arrow_back_ios_new),
              iconSize: 25,
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: IconButton(
                onPressed: () {
                  openDialog();
                },
                icon: const Icon(Icons.info_sharp),
                iconSize: 25,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Image.asset(
              (widget.selecao.bandeira ?? ''),
              height: 100,
              width: 90,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                '${widget.selecao.pais ?? ''} (${widget.selecao.index})',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                '${((widget.selecao.cromosAtivos / widget.selecao.qtdeCromos) * 100).toStringAsFixed(1)} %',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: (1 / 1.4),
                  ),
                  itemCount: cromos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.blue,
                              width: 1.0,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                children: [
                                  Text(
                                    cromos[index].descricao ?? '',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Visibility(
                                    child: Expanded(
                                      child: Image.asset(
                                        'images/check.png',
                                      ),
                                    ),
                                    visible: cromos[index].ativo ?? false,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        onDoubleTap: () {
                          setState(() {
                            if (cromos[index].ativo ?? false) {
                              cromos[index].ativo = false;
                            } else {
                              cromos[index].ativo = true;
                            }
                            _salvarCromos(widget.selecao.index);
                            _atualizarSelecao();
                          });
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey[50],
      ),
    );
  }
}
