class Remolques {

  String matricula = "";

  Remolques(this.matricula);

  Remolques.vacio();

  Map<String, dynamic> toMap() {
    return {"matricula": matricula};
  }

  void setMatricula(String matricula){
    this.matricula = matricula;
  }
}
