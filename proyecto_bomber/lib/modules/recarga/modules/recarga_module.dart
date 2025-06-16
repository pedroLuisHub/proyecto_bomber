import 'package:bomber/core/components/module/core_module.dart';
import 'package:bomber/modules/recarga/controller/recarga_controller.dart';
import 'package:bomber/modules/recarga/pages/recarga_abm.dart';
import 'package:bomber/modules/recarga/pages/recarga_lista_page.dart';
import 'package:bomber/modules/recarga/pages/recarga_reporte.dart';
import 'package:bomber/modules/recarga/repositories/recarga_repository.dart';
import 'package:bomber/modules/recarga/service/recarga_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RecargaModule extends Module {
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addSingleton(RecargaRepository.new);
    i.addSingleton(RecargaService.new);
    i.addSingleton(RecargaController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const RecargaListaPage());
    r.child('/abm_recarga', child: (_) => const RecargaAbm());
    r.child('/reporte_recarga', child: (_) => ReporteRecarga());
  }
}
