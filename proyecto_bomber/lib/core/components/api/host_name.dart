class Hostname {
  String ip = "";

  Hostname._privateConstructor();

  static final Hostname _instance = Hostname._privateConstructor();

  static Hostname get instance => _instance;

  init() async {
    ip = "http://localhost:8080";

    // if (host != null) {
    //   ip = "http://$host/ConceptoComercialJ/";
    // }
  }
}
