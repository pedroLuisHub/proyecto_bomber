import 'package:bomber/modules/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
    // CoreModule(),
  ];

  @override
  void routes(r) {

    r.module('/', module: HomeModule());
    // r.module('/bombero', module: BomberoModule());
  }
}
