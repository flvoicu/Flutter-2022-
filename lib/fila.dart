class Fila {

  late String muelle='';
  late String matricula='';
  late String observaciones='';

  Fila(this.muelle, this.matricula, this.observaciones);

  Fila.vacia();

  Fila.todo({required this.muelle, required this.matricula, required this.observaciones});

  Map<String, dynamic> toMap() {
    return {'muelle':muelle, 'matricula': matricula, 'observaciones': observaciones };
  }

  void setMuelle(String muelle){
    this.muelle = muelle;
  }
  void setMatricula(String matricula){
    this.matricula = matricula;
  }
  void setObservaciones(String observaciones){
    this.observaciones = observaciones;
  }

  String getMuelle(){
    return muelle;
  }
  String getMatricula(){
    return matricula;
  }
  String getObservaciones(){
    return observaciones;
  }
}
