import 'package:bomber/core/components/module/core_module.dart';
import 'package:bomber/modules/ciudadano/controller/ciudadano_controller.dart';
import 'package:bomber/modules/ciudadano/pages/ciudadano_abm.dart';
import 'package:bomber/modules/ciudadano/pages/ciudadano_lista_page.dart';
import 'package:bomber/modules/ciudadano/pages/ciudadano_reporte.dart';
import 'package:bomber/modules/ciudadano/pages/ciudadano_selector_page.dart';
import 'package:bomber/modules/ciudadano/repositories/ciudadano_repository.dart';
import 'package:bomber/modules/ciudadano/services/ciudadano_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CiudadanoModule extends Module {
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addSingleton(CiudadanoRepository.new);
    i.addSingleton(CiudadanoService.new);
    i.addSingleton(CiudadanoController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const CiudadanoListaPage());
    r.child('/abm_ciudadano', child: (_) => const CiudadanoAbm());
    r.child('/select', child: (_) => CiudadanoSelectorPage());
    r.child('/reporte_ciudadano', child: (_) => ReporteCiudadano());
  }
}
