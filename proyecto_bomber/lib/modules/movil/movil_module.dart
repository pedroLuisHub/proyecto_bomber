import 'package:bomber/core/components/module/core_module.dart';
import 'package:bomber/modules/movil/pages/movil_abm.dart';
import 'package:bomber/modules/movil/controller/movil_controller.dart';
import 'package:bomber/modules/movil/pages/movil_lista_page.dart';
import 'package:bomber/modules/movil/repositories/movil_repository.dart';
import 'package:bomber/modules/movil/services/movil_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MovilModule extends Module{

  List<Module> get imports => [CoreModule()];

    @override
  void binds(i) {
    i.addSingleton(MovilRepository.new);
    i.addSingleton(MovilService.new);
    i.addSingleton(MovilController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const MovilListaPage());
    r.child('/abm_movil', child: (_) => const MovilAbm());
  }

}