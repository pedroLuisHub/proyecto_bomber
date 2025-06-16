import 'package:bomber/core/components/module/core_module.dart';
import 'package:bomber/modules/bombero/model/bombero.dart';
import 'package:bomber/modules/bombero/pages/bombero_abm.dart';
import 'package:bomber/modules/bombero/controller/bombero_controller.dart';
import 'package:bomber/modules/bombero/pages/bombero_lista_page.dart';
import 'package:bomber/modules/bombero/pages/bombero_selector_page.dart';
import 'package:bomber/modules/bombero/pages/bombero_reporte.dart';
import 'package:bomber/modules/bombero/repositories/bombero_repository.dart';
import 'package:bomber/modules/bombero/services/bombero_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BomberoModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addSingleton(BomberoRepository.new);
    i.addSingleton(BomberoService.new);
    i.addSingleton(BomberoController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const BomberoListaPage());
    r.child('/abm_bombero', child: (_) => const BomberoAbm());
    r.child('/select', child: (_) => BomberoSelectorPage());
    r.child('/reporte_bombero', child: (_) => ReporteBombero());
  }
}
