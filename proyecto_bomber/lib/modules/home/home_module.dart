import 'package:bomber/core/components/module/core_module.dart';
import 'package:bomber/modules/abastecimiento/modules/abastecimiento_module.dart';
import 'package:bomber/modules/bombero/modules/bombero_module.dart';
import 'package:bomber/modules/ciudadano/modules/ciudadano_module.dart';
import 'package:bomber/modules/deposito/modules/deposito_module.dart';
import 'package:bomber/modules/home/pages/home_page.dart';
import 'package:bomber/modules/movil/modules/movil_module.dart';
import 'package:bomber/modules/recarga/modules/recarga_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    // i.addSingleton(BomberoRepository.new);
    // i.addSingleton(BomberoService.new);
    // i.addSingleton(BomberoController.new);
    // i.addSingleton(MovilRepository.new);
    // i.addSingleton(MovilService.new);
    // i.addSingleton(MovilController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const HomePage());
    r.module('/bombero', module: BomberoModule());
    r.module('/movil', module: MovilModule());
    r.module('/ciudadano', module: CiudadanoModule());
    r.module('/deposito', module: DepositoModule());
    r.module('/recarga', module: RecargaModule());
    r.module('/abastecimiento', module: AbastecimientoModule());

  }
}
