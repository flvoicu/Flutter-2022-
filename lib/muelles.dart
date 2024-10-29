class Muelles {

  String muelle = "";

  Muelles(this.muelle);

  Muelles.vacio();

  Map<String, dynamic> toMap() {
    return {"muelle": muelle};
  }

  void setMuelle(String muelle){
    this.muelle = muelle;
  }
  String getMuelle(){
    return muelle;
  }
}
