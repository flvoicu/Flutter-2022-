import 'package:muelles/fila_lista.dart';
import 'package:muelles/fila_remolques.dart';
import 'package:muelles/boton.dart';
import 'package:muelles/fila_string.dart';
import 'package:flutter/material.dart';

class list_view_variable extends StatefulWidget {
  final String caso;
  late Widget widget;
  final String funcionBoton;
  final String titulo;
  final List<dynamic> lista;
  final String data;

  list_view_variable({
    required this.caso,
    required this.funcionBoton,
    required this.titulo,
    this.data = '',
    this.lista = const [],
  });

  @override
  State<StatefulWidget> createState() {
    return list_view_variable_state();
  }
}

class list_view_variable_state extends State<list_view_variable> {
  List<dynamic> listaWidget = [];

  bool visible1 = true;
  bool visible2 = true;

  @override
  Widget build(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width;

    switch (widget.caso) {
      case 'aniadirDia':
        widget.widget = fila_remolques(crear: true);
        if (listaWidget.isEmpty) {
          listaWidget.add(widget.widget);
        }
        break;
      case 'verDia':
        if (widget.lista.isNotEmpty) {
          if (listaWidget.isEmpty) {
            for (var i = 0; i < widget.lista.length; i++) {
              widget.widget = fila_lista(
                key: Key(i.toString()),
                data: widget.lista[i],
                ancho: ancho,
                tipo: 'dia',
              );
              listaWidget.add(widget.widget);
            }
          }
        } else {
          widget.widget = fila_lista(
            data: 'Aún no hay ningun día',
            tipo: 'dia',
            ancho: ancho,
          );
          listaWidget.add(widget.widget);
        }
        visible1 = false;
        visible2 = false;
        break;
      case 'editarDia':
        if (listaWidget.isEmpty) {
          for (var i = 0; i < widget.lista.length; i++) {
            widget.widget = fila_remolques(
              key: Key(i.toString()),
              crear: true,
              valor1: widget.lista[i].getMuelle(),
              valor2: widget.lista[i].getMatricula(),
              valor3: widget.lista[i].getObservaciones(),
            );
            listaWidget.add(widget.widget);
          }
        }
        visible1 = false;
        break;
      case 'aniadirMuelles':
        widget.widget = fila_string(nombre: 'Muelle');
        if (listaWidget.isEmpty) {
          listaWidget.add(widget.widget);
        }
        break;
      case 'verMuelles':
        if (widget.lista.isNotEmpty) {
          if (listaWidget.isEmpty) {
            for (var i = 0; i < widget.lista.length; i++) {
              widget.widget = fila_lista(
                key: Key(i.toString()),
                data: widget.lista[i],
                ancho: ancho,
                tipo: 'muelle',
              );
              listaWidget.add(widget.widget);
            }
          }
        } else {
          widget.widget = fila_lista(
            data: 'Aún no hay ningun muelle',
            tipo: 'muelle',
            ancho: ancho,
          );
          listaWidget.add(widget.widget);
        }
        visible1 = false;
        visible2 = false;
        break;
      case 'editarMuelle':
        if (listaWidget.isEmpty) {
          widget.widget = fila_string(
            nombre: 'Muelle',
            valor: widget.data,
          );
          listaWidget.add(widget.widget);
        }
        visible1 = false;
        break;
      case 'aniadirRemolques':
        widget.widget = fila_string(nombre: 'Remolque');
        if (listaWidget.isEmpty) {
          listaWidget.add(widget.widget);
        }
        break;
      case 'verRemolques':
        if (widget.lista.isNotEmpty) {
          if (listaWidget.isEmpty) {
            for (var i = 0; i < widget.lista.length; i++) {
              widget.widget = fila_lista(
                key: Key(i.toString()),
                data: widget.lista[i],
                ancho: ancho,
                tipo: 'remolque',
              );
              listaWidget.add(widget.widget);
            }
          }
        } else {
          widget.widget = fila_lista(
            data: 'Aún no hay ningun remolque',
            tipo: 'remolque',
            ancho: ancho,
          );
          listaWidget.add(widget.widget);
        }
        visible1 = false;
        visible2 = false;
        break;
      case 'editarRemolque':
        if (listaWidget.isEmpty) {
            widget.widget = fila_string(
              nombre: 'Remolque',
              valor: widget.data,
            );
            listaWidget.add(widget.widget);
        }
        visible1 = false;
        break;
    }

    void addWidget() {
      setState(
        () {
          listaWidget.add(widget.widget);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
        centerTitle: true,
      ),
      floatingActionButton: Align(
        alignment: const Alignment(1, 0.88),
        child: Visibility(
          visible: visible1,
          child: FloatingActionButton(
            onPressed: () {
              addWidget();
            },
            tooltip: 'Add',
            child: const Icon(Icons.add),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              addAutomaticKeepAlives: true,
              itemCount: listaWidget.length,
              itemBuilder: (context, index) {
                return listaWidget[index];
              },
            ),
          ),
          Visibility(
            child: Boton.todo(
              valorBoton: 'Guardar',
              funcion: widget.funcionBoton,
              data: widget.data,
            ),
            visible: visible2,
          ),
        ],
      ),
    );
  }
}
