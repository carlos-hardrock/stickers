import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controller/cromo_controller.dart';
import '../model/selecao.dart';
import '../widgets/w_bandeira.dart';

class SelecaoPage extends StatefulWidget {
  final String title;

  SelecaoPage({Key? key, required this.title}) : super(key: key);

  @override
  State<SelecaoPage> createState() => _SelecaoPageState();
}

class _SelecaoPageState extends State<SelecaoPage> {
  List<Selecao> selecoes = CromoCrontroller.listarSelecoes();
  List<Selecao> lista = [];

  @override
  void initState() {
    super.initState();
    selecoes.forEach((elemento) {
      CromoCrontroller.listarCromos(elemento).then((value) {
        elemento.setCromosAtivos = CromoCrontroller.retornarCromosAtivos(value);
        setState(() {
          lista.add(elemento);
        });
      });
    });
  }

  String _percentualGeral() {
    int ativos = 0;
    int totalCromosAlbum = 0;

    lista.forEach((sel) {
      ativos += sel.cromosAtivos;
      totalCromosAlbum += sel.qtdeCromos;
    });

    return ((ativos / totalCromosAlbum) * 100).toStringAsFixed(1) + '%';
  }

  Future<bool?> _showConfirmationDualog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Deseja sair do app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Sim'),
              ),
              OutlinedButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Não'),
              ),
            ],
          );
        });
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Informações"),
          content: const Text(
              "Este aplicativo foi desenvolvido por (carlos.hardrock@gmail.com) para uso totalmente gratuito, sendo expressamente proibido a sua comercialização. \nCaso queira contribuir com o projeto, envie um PIX para o fone: (41)999502834"),
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
        final confirmation = await _showConfirmationDualog();

        if ((confirmation ?? false)) {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else {
            exit(0);
          }
        }

        return confirmation ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title + '  (${_percentualGeral()})'),
          leading: const Icon(Icons.sports_soccer_sharp),
          actions: [
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
            Expanded(
              child: WidgetBandeira(
                title: widget.title,
                lista: lista,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
