import 'package:muelles/list_view_variable.dart';
import 'package:muelles/muelles.dart';
import 'package:muelles/remolques.dart';
import 'package:flutter/material.dart';
import 'fila.dart';

class Colecciones {
  static List<String> listaMatriculas = <String>[
    'V000000',
    'V11111',
    'V22222',
    'Z000000',
    'M00000',
    'R00000',
    'R11111',
  ];

  static Map<String, String> toMapMatricula(String matricula) {
    return {'matricula': matricula};
  }

  static List<String> listaMatriculasAdd = <String>[];

  static List<String> listaMuelles = <String>[
    'M1',
    'M2',
    'M3',
  ];

  static List<String> listaMuellesAdd = <String>[];

  static List<Fila> listaFilas = <Fila>[];

  static void listaFilasAddFila() {
    listaFilas.add(Fila.vacia());
  }

  static List<String> listaDias = <String>[];

  static Map<String, String> toMapMuelle(String muelle) {
    return {'muelle': muelle};
  }

  static Route<dynamic> generarRuta(RouteSettings ajustes) {
    Map? args = ajustes.arguments as Map?;
    switch (ajustes.name) {
      case '/aniadirDia':
        return MaterialPageRoute(
            builder: (_) => list_view_variable(
                caso: 'aniadirDia',
                titulo: 'Añadir dia',
                funcionBoton: 'guardarDia'));
      case '/listadoDias':
        return MaterialPageRoute(
            builder: (_) => list_view_variable(
                  caso: 'verDia',
                  titulo: 'Listado de días',
                  lista: listaDias,
                  funcionBoton: '',
                ));
      case '/editarDia':
        List<Fila> lista = args!['lista'];
        String dia = args['dia'];
        return MaterialPageRoute(
            builder: (_) => list_view_variable(
                  caso: 'editarDia',
                  titulo: 'Editar dia',
                  lista: lista,
                  funcionBoton: 'editarDia',
                  data: dia,
                ));
      case '/aniadirMuelle':
        return MaterialPageRoute(
            builder: (_) => list_view_variable(
                caso: 'aniadirMuelles',
                titulo: 'Añadir muelles',
                funcionBoton: 'guardarMuelle'));
      case '/listadoMuelles':
        return MaterialPageRoute(
            builder: (_) => list_view_variable(
                  caso: 'verMuelles',
                  titulo: 'Listado de muelles',
                  lista: listaMuelles,
                  funcionBoton: 'editarMuelleVista',
                ));
      case '/editarMuelle':
        String muelle = args!['muelle'];
        return MaterialPageRoute(
            builder: (_) => list_view_variable(
                  caso: 'editarMuelle',
                  titulo: 'Editar muelle',
                  data: muelle,
                  funcionBoton: 'editarMuelle',
                ));
      case '/aniadirRemolques':
        return MaterialPageRoute(
            builder: (_) => list_view_variable(
                caso: 'aniadirRemolques',
                titulo: 'Añadir remolque',
                funcionBoton: 'guardarRemolque'));
      case '/listadoRemolques':
        return MaterialPageRoute(
            builder: (_) => list_view_variable(
                  caso: 'verRemolques',
                  titulo: 'Listado de remolques',
                  lista: listaMatriculas,
                  funcionBoton: 'editarRemolqueVista',
                ));
      case '/editarRemolque':
        String remolque = args!['remolque'];
        return MaterialPageRoute(
            builder: (_) => list_view_variable(
                  caso: 'editarRemolque',
                  titulo: 'Editar remolque',
                  data: remolque,
                  funcionBoton: 'editarRemolque',
                ));
      default:
        return errorRuta();
    }
  }

  static Route<dynamic> errorRuta() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('error'),
          ),
          body: const Center(
            child: Text('error'),
          ),
        );
      },
    );
  }
}
