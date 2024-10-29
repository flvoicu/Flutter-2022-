import 'package:flutter/material.dart';

import 'colecciones.dart';

class fila_string extends StatefulWidget {
  final String nombre;
  final List<String> lista;
  final String valor;

  fila_string({
    Key? key,
    required this.nombre,
    this.lista = const <String> [],
    this.valor = '',
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => fila_string_state();
}

class fila_string_state extends State<fila_string>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {

    int indice = 0;

    double ancho = MediaQuery.of(context).size.width;
    double ancho1 = 0;
    double ancho2 = 0;

    switch (widget.nombre) {
      case 'Muelle':
        Colecciones.listaMuellesAdd.add('');
        indice = Colecciones.listaMuellesAdd.length - 1;
        ancho1 = ancho/5;
        ancho2 = ancho/10;
        break;
      case 'Remolque':
        Colecciones.listaMatriculasAdd.add('');
        indice = Colecciones.listaMatriculasAdd.length - 1;
        ancho1 = ancho/4;
        ancho2 = ancho/4.5;
        break;
    }

    const EdgeInsets valor = EdgeInsets.all(8);

    return Container(
      width: ancho,
      margin: valor,
      padding: valor,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              widget.nombre + ':',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
            alignment: Alignment.center,
            height: 25,
            width: ancho1,
          ),
          Container(
            child: TextField(
              onChanged: (text) {
                switch (widget.nombre) {
                  case 'Muelle':
                    Colecciones.listaMuellesAdd[indice] = text.toUpperCase();
                    break;
                  case 'Remolque':
                    Colecciones.listaMatriculasAdd[indice] = text.toUpperCase();
                    break;
                }
              },
              textAlignVertical: TextAlignVertical.bottom,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: widget.valor,
              ),
            ),
            height: 25,
            width: ancho2,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    switch (widget.nombre) {
      case 'Muelle':
        Colecciones.listaMuellesAdd.clear();
        break;
      case 'Remolque':
        Colecciones.listaMatriculasAdd.clear();
        break;
    }
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
