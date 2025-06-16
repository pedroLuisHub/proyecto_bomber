import 'package:bomber/core/components/module/core_module.dart';
import 'package:bomber/modules/abastecimiento/controller/abastecimiento_controller.dart';
import 'package:bomber/modules/abastecimiento/pages/abastecimiento_abm.dart';
import 'package:bomber/modules/abastecimiento/pages/abastecimiento_lista_page.dart';
import 'package:bomber/modules/abastecimiento/pages/abastecimiento_reporte.dart';
import 'package:bomber/modules/abastecimiento/repositories/abastecimiento_repository.dart';
import 'package:bomber/modules/abastecimiento/services/abastecimiento_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AbastecimientoModule extends Module {
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addSingleton(AbastecimientoRepository.new);
    i.addSingleton(AbastecimientoService.new);
    i.addSingleton(AbastecimientoController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const AbastecimientoListaPage());
    r.child('/abm_abastecimiento', child: (_) => const AbastecimientoAbm());
    r.child('/reporte_abastecimiento', child: (_) => ReporteAbastecimiento());
  }
}
