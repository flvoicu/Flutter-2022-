import 'package:muelles/crearPDF.dart';
import 'package:flutter/material.dart';

import 'boton.dart';

class fila_lista extends StatelessWidget {
  CrearPDF pdf = CrearPDF();
  final String data;
  final double ancho;
  final String tipo;

  fila_lista({
    Key? key,
    required this.data,
    required this.tipo,
    this.ancho = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool visible1 = true;
    bool visible2 = true;

    String funcionEditar = '';
    String rutaEditar = '';
    String funcionEliminar = '';

    switch (tipo) {
      case 'dia':
        if (data == 'Aún no hay ningun día') {
          visible1 = false;
          visible2 = false;
        } else {
          funcionEditar = 'editarDiaVista';
          rutaEditar = '/editarDia';
          funcionEliminar = 'eliminarDia';
        }
        break;
      case 'muelle':
        if (data == 'Aún no hay ningun muelle') {
          visible1 = false;
        }
        visible2 = false;
        funcionEditar = 'editarMuelleVista';
        rutaEditar = '/editarMuelle';
        funcionEliminar = 'eliminarMuelle';
        break;
      case 'remolque':
        if (data == 'Aún no hay ningun remolque') {
          visible1 = false;
        }
        visible2 = false;
        funcionEditar = 'editarRemolqueVista';
        rutaEditar = '/editarRemolque';
        funcionEliminar = 'eliminarRemolque';
        break;
    }
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8, left: 6, right: 6),
          child: Text(
            data,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24),
          ),
          alignment: Alignment.center,
        ),
        Visibility(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Boton.todo(
                valorBoton: 'Editar',
                ancho: ancho / 3,
                funcion: funcionEditar,
                rutaBoton: rutaEditar,
                data: data,
              ),
              Boton.todo(
                valorBoton: 'Eliminar',
                ancho: ancho / 3,
                funcion: funcionEliminar,
                data: data,
              )
            ],
          ),
          visible: visible1,
        ),
        Visibility(
          child: Container(
            width: ancho/1.5,
            margin: const EdgeInsets.only(left: 4, right: 4),
            padding: const EdgeInsets.all(4),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 18),
                  minimumSize: const Size(double.infinity, 40),
                ),
                child: const Text('Exportar día'),
                onPressed: () async{
                  final lista = await pdf.crearPdfDias(data);
                  pdf.guardarPDF('Día', lista);
                }),
          ),
          visible: visible2,
        )
      ],
    );
  }
}
