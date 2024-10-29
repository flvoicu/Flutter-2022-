import 'package:muelles/fila.dart';
import 'package:flutter/material.dart';
import './auto_completar.dart';

import 'colecciones.dart';

class fila_remolques extends StatefulWidget {
  final bool crear;
  String valor1;
  String valor2;
  String valor3;

  fila_remolques(
      {Key? key,
      required this.crear,
      this.valor1 = '',
      this.valor2 = '',
      this.valor3 = 'Observaciones'})
      : super(key: key);

  setValores(String valor1, String valor2, String valor3) {
    this.valor1 = valor1;
    this.valor2 = valor2;
    this.valor3 = valor3;
  }

  @override
  State<StatefulWidget> createState() => fila_remolques_state();
}

class fila_remolques_state extends State<fila_remolques>
    with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {

    int indice = 0;

    if (widget.crear == true) {
      Fila fila = Fila.vacia();
      Colecciones.listaFilas.add(fila);
      indice = Colecciones.listaFilas.length - 1;
      Colecciones.listaFilas[indice].setObservaciones(widget.valor3);
    }

    double ancho = MediaQuery.of(context).size.width;

    const EdgeInsets valor = EdgeInsets.all(8);

    return Container(
      width: ancho,
      margin: valor,
      padding: valor,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: const Text(
                  "Muelle:",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                alignment: Alignment.center,
                height: 25,
                width: ancho / 5,
              ),
              Container(
                child: AutoCompletar.todo(
                  lista: Colecciones.listaMuelles,
                  funcion: 'guardarMuelleDia',
                  indice: indice,
                  valor: widget.valor1,
                ),
                height: 25,
                width: ancho / 10,
              ),
              Container(
                child: const Text(
                  "Matrícula:",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                alignment: Alignment.center,
                height: 25,
                width: ancho / 4,
              ),
              Container(
                child: AutoCompletar.todo(
                  lista: Colecciones.listaMatriculas,
                  funcion: 'guardarMatriculaDia',
                  indice: indice,
                  valor: widget.valor2,
                ),
                height: 25,
                width: ancho / 4.5,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: TextField(
                  onChanged: (text) {
                    if (widget.crear) {
                      Colecciones.listaFilas[indice].setObservaciones(text);
                    }
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: widget.valor3,
                  ),
                ),
                height: 50,
                width: ancho / 1.2,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Colecciones.listaFilas.clear();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
