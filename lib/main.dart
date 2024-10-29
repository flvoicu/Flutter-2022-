import 'package:muelles/boton.dart';
import 'package:muelles/colecciones.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late TabController controlador;

  @override
  void initState() {
    super.initState();

    controlador = TabController(length: 3, vsync: this);
    controlador.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controlador.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String titulo = '';
    switch (controlador.index) {
      case 0:
        titulo = 'Días';
        break;
      case 1:
        titulo = 'Muelles';
        break;
      case 2:
        titulo = 'Remolques';
        break;
    }

    return MaterialApp(
      onGenerateRoute: Colecciones.generarRuta,
      home: Scaffold(
        appBar: AppBar(
          title: Text(titulo),
          centerTitle: true,
        ),
        body: TabBarView(
          controller: controlador,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Boton.todo(
                  valorBoton: "Añadir",
                  funcion: 'navegar',
                  rutaBoton: '/aniadirDia',
                ),
                Boton.todo(
                  valorBoton: "Listado de días",
                  funcion: 'navegar',
                  rutaBoton: '/listadoDias',
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Boton.todo(
                  valorBoton: "Añadir",
                  funcion: 'navegar',
                  rutaBoton: '/aniadirMuelle',
                ),
                Boton.todo(
                  valorBoton: "Listado de muelles",
                  funcion: 'navegar',
                  rutaBoton: '/listadoMuelles',
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Boton.todo(
                  valorBoton: "Añadir",
                  funcion: 'navegar',
                  rutaBoton: '/aniadirRemolques',
                ),
                Boton.todo(
                  valorBoton: "Listado de remolques",
                  funcion: 'navegar',
                  rutaBoton: '/listadoRemolques',
                ),
              ],
            )
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.blue,
          child: TabBar(
            indicatorColor: Colors.white,
            controller: controlador,
            tabs: const [
              Tab(
                icon: Icon(Icons.calendar_month_outlined),
              ),
              Tab(
                icon: Icon(Icons.business_outlined),
              ),
              Tab(
                icon: Icon(Icons.airport_shuttle_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
