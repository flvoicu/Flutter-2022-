import 'package:muelles/colecciones.dart';
import 'package:flutter/material.dart';

class AutoCompletar extends StatelessWidget {
  final List<String> lista;
  final String funcion;
  final int indice;
  final String valor;

  const AutoCompletar.todo(
      {required this.lista,
      required this.funcion,
      required this.indice,
      this.valor = ''});

  @override
  Widget build(BuildContext context) {
    guardarDatos(funcion, valor);

    return Autocomplete<String>(
      initialValue: TextEditingValue(text: valor),
      optionsMaxHeight: 150,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return lista;
        }
        return lista.where((String option) {
          return option.contains(textEditingValue.text.toUpperCase());
        });
      },
      onSelected: (String selection) {
        guardarDatos(funcion, selection);
      },
    );
  }

  void guardarDatos(String funcion, String selection) {
    switch (funcion) {
      case 'guardarMuelleDia':
        Colecciones.listaFilas[indice].setMuelle(selection);
        break;
      case 'guardarMatriculaDia':
        Colecciones.listaFilas[indice].setMatricula(selection);
        break;
    }
  }
}
