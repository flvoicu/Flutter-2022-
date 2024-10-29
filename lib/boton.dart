import 'package:muelles/colecciones.dart';
import 'package:flutter/material.dart';

import 'db.dart';
import 'fila.dart';

class Boton extends StatelessWidget {
  final String valorBoton;
  final String rutaBoton;
  final String funcion;
  final dynamic data;
  late double ancho;

  Boton.todo(
      {required this.valorBoton,
      required this.funcion,
      this.rutaBoton = '',
      this.ancho = 0,
      this.data = ''});

  @override
  Widget build(BuildContext context) {
    if (ancho == 0) {
      ancho = MediaQuery.of(context).size.width;
    }

    return Container(
      width: ancho,
      margin: const EdgeInsets.only(left: 4, right: 4),
      padding: const EdgeInsets.all(4),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 18),
            minimumSize: const Size(double.infinity, 40),
          ),
          child: Text(valorBoton),
          onPressed: () {
            funcionBoton(funcion: funcion, context: context, data: data);
          }),
    );
  }

  void funcionBoton(
      {required String funcion,
      required BuildContext context,
      dynamic data = ''}) {
    switch (funcion) {
      case 'navegar':
        Navigator.pushNamed(
          context,
          rutaBoton,
        );
        break;
      case 'guardarDia':
        DB.crearDia();
        break;
      case 'eliminarDia':
        DB.eliminarDia(data);
        break;
      case 'editarDiaVista':
        List<Fila> lista = [];
        DB.listaDia(data).then((value) {
          lista = value;
          Navigator.pushNamed(
            context,
            rutaBoton,
            arguments: <String, dynamic>{'lista': lista, 'dia': data},
          );
        });
        break;
      case 'editarDia':
        DB.editarDia(data);
        break;
      case 'guardarMuelle':
        DB.guardarMuelles();
        break;
      case 'eliminarMuelle':
        DB.eliminarMuelle(data);
        break;
      case 'editarMuelleVista':
        Navigator.pushNamed(
          context,
          rutaBoton,
          arguments: <String, dynamic>{'muelle': data},
        );
        break;
      case 'editarMuelle':
        Colecciones.listaMuelles.remove(data);
        DB.updateMuelle(Colecciones.listaMuellesAdd[0]);
        break;
      case 'guardarRemolque':
        DB.guardarRemolques();
        break;
      case 'eliminarRemolque':
        DB.eliminarRemolque(data);
        break;
      case 'editarRemolqueVista':
        Navigator.pushNamed(
          context,
          rutaBoton,
          arguments: <String, dynamic>{'remolque': data},
        );
        break;
      case 'editarRemolque':
        Colecciones.listaMatriculas.remove(data);
        DB.updateRemolque(Colecciones.listaMatriculasAdd[0]);
        break;
    }
  }
}
