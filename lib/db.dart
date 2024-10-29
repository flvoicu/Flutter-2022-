import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'muelles.dart';
import 'remolques.dart';
import './fila.dart';
import './colecciones.dart';

class DB {
  static Future<Database> _openDB() async {
    // creamos la bbdd

    return openDatabase(
        join(
            await getDatabasesPath(), 'general.db'), // ruta y nombre de la bbdd
        onCreate: (db, version) {
      // si no existe la bbdd se ejecuta:
      db.execute('CREATE TABLE remolques (matricula TEXT PRIMARY KEY)');
      Colecciones.listaMatriculas.forEach(
        (matricula) async {
          db.insert('remolques', Colecciones.toMapMatricula(matricula));
        },
      );
      db.execute('CREATE TABLE muelles (muelle TEXT PRIMARY KEY)');
      Colecciones.listaMuelles.forEach(
        (muelle) async {
          db.insert('muelles', Colecciones.toMapMuelle(muelle));
        },
      );
    }, version: 1);
  }

  // Remolques
  static Future<void> insertRemolque(Remolques remolque) async {
    Database database = await _openDB(); //abrir bbdd

    database.insert('remolques', remolque.toMap());
  }

  static Future<void> deleteRemolque(Remolques remolque) async {
    Database database = await _openDB();

    database.delete('remolques',
        where: 'matricula = ?', whereArgs: [remolque.matricula]);
  }

  static Future<void> updateRemolque(String remolqueNom) async {
    Remolques remolque = Remolques(remolqueNom);

    Database database = await _openDB();
    database.update('remolques', remolque.toMap(),
        where: 'matricula = ?', whereArgs: [remolque.matricula]);

    if (!Colecciones.listaMatriculas.contains(remolqueNom)) {
      Colecciones.listaMatriculas.add(remolqueNom);
    }
    Colecciones.listaMatriculasAdd.clear();
  }

  static Future<void> guardarRemolques() async {
    Remolques remolque;
    for (var i = 0; i < Colecciones.listaMatriculasAdd.length; i++) {
      remolque = Remolques(Colecciones.listaMatriculasAdd[i]);
      insertRemolque(remolque);
      if (!Colecciones.listaMatriculas.contains(Colecciones.listaMatriculasAdd[i])) {
        Colecciones.listaMatriculasAdd.add(Colecciones.listaMatriculasAdd[i]);
      }
    }
    Colecciones.listaMatriculasAdd.clear();
  }

  static Future<void> eliminarRemolque(String matricula) async {
    Remolques remolque = Remolques(matricula);
    Colecciones.listaMatriculas.removeWhere((element) => element == matricula);
    deleteRemolque(remolque);
  }

  static Future<List<Remolques>> listaRemolques() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> remolquesMap =
        await database.query('remolques');

    return List.generate(
      remolquesMap.length,
      (i) => Remolques(remolquesMap[i]['matricula']),
    );
  }
  //***

  // Muelles
  static Future<void> insertMuelle(Muelles muelle) async {
    Database database = await _openDB(); //abrir bbdd

    database.insert('muelles', muelle.toMap());
  }

  static Future<void> deleteMuelle(Muelles muelle) async {
    Database database = await _openDB();

    database.delete('muelles', where: 'muelle = ?', whereArgs: [muelle.muelle]);
  }

  static Future<void> guardarMuelles() async {
    Muelles muelle;
    for (var i = 0; i < Colecciones.listaMuellesAdd.length; i++) {
      muelle = Muelles(Colecciones.listaMuellesAdd[i]);
      insertMuelle(muelle);
      if (!Colecciones.listaMuelles.contains(Colecciones.listaMuellesAdd[i])) {
        Colecciones.listaMuelles.add(Colecciones.listaMuellesAdd[i]);
      }
    }
    Colecciones.listaMuellesAdd.clear();
  }

  static Future<void> eliminarMuelle(String nombre) async {
    Muelles muelle = Muelles(nombre);
    Colecciones.listaMuelles.removeWhere((element) => element == nombre);
    deleteMuelle(muelle);
  }

  static Future<void> updateMuelle(String muelleNom) async {
    Muelles muelle = Muelles(muelleNom);

    Database database = await _openDB();
    database.update('muelles', muelle.toMap(),
        where: 'nombre = ?', whereArgs: [muelle.muelle]);

    if (!Colecciones.listaMuelles.contains(muelleNom)) {
      Colecciones.listaMuelles.add(muelleNom);
    }
    Colecciones.listaMuellesAdd.clear();
  }

  static Future<List<Muelles>> listaMuelles() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> muellesMap =
        await database.query('muelles');

    return List.generate(
      muellesMap.length,
      (i) => Muelles(muellesMap[i]['muelle']),
    );
  }
  //***

  // Dias
  static Future<void> insertFilaDia(Fila fila, String dia) async {
    Database database = await _openDB();
    database.insert(dia, fila.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> crearDia() async {
    String dia = DateTime.now().day.toString() +
        '/' +
        DateTime.now().month.toString() +
        '/' +
        DateTime.now().year.toString();
    String nombre = '[' + dia + ']';

    Database database = await _openDB();

    database.execute(
        'CREATE TABLE IF NOT EXISTS $nombre ( muelle TEXT, matricula TEXT PRIMARY KEY, observaciones TEXT)');

    for (var i = 0; i < Colecciones.listaFilas.length; i++) {
      insertFilaDia(Colecciones.listaFilas[i], nombre);
    }

    if (!Colecciones.listaDias.contains(dia)) {
      Colecciones.listaDias.add(dia);
    }
    Colecciones.listaFilas.clear();
  }

  static Future<void> eliminarDia(String dia) async {
    Database database = await _openDB();
    String nombre = '[' + dia + ']';
    database.execute('DROP TABLE IF EXISTS $nombre');
    Colecciones.listaDias.remove(dia);
  }

  static Future<void> editarDia(String dia) async {
    Database database = await _openDB();
    String nombre = '[' + dia + ']';
    database.execute('DELETE FROM $nombre');
    for (var i = 0; i < Colecciones.listaFilas.length; i++) {
      insertFilaDia(Colecciones.listaFilas[i], nombre);
    }
  }

  static Future<List<Fila>> listaDia(String dia) async {
    String nombre = '[' + dia + ']';

    Database database = await _openDB();

    final List<Map<String, dynamic>> diaMap = await database.query(nombre);

    return List.generate(
      diaMap.length,
      (i) => Fila(diaMap[i]['muelle'], diaMap[i]['matricula'],
          diaMap[i]['observaciones']),
    );
  }
  //***
}
