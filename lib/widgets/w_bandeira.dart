import 'package:flutter/material.dart';

import '../controller/cromo_controller.dart';
import '../model/selecao.dart';
import '../pages/cromo_page.dart';

class WidgetBandeira extends StatefulWidget {
  List<Selecao> selecoes = CromoCrontroller.listarSelecoes();
  String title;
  List<Selecao> lista;
  WidgetBandeira({Key? key, required this.title, required this.lista})
      : super(key: key);

  @override
  State<WidgetBandeira> createState() => _WidgetBandeiraState();
}

class _WidgetBandeiraState extends State<WidgetBandeira> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: (1 / 1.05),
        ),
        itemCount: widget.lista.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Image.asset(
                          widget.lista[index].bandeira ?? '',
                          height: 40,
                          width: 50,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        widget.lista[index].index ?? '',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                          '${((widget.lista[index].cromosAtivos / widget.lista[index].qtdeCromos) * 100).toStringAsFixed(1)} %'),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      border: Border.all(
                        color: Colors.blue,
                        width: 1.0,
                      )),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CromoPage(
                      title: widget.title,
                      selecao: widget.lista[index],
                    ),
                  ),
                ).then((value) {
                  setState(() {});
                });
              });
        });
  }
}
