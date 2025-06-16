import 'package:bomber/core/components/module/core_module.dart';
import 'package:bomber/modules/ciudadano/modules/ciudadano_module.dart';
import 'package:bomber/modules/deposito/controller/deposito_controller.dart';
import 'package:bomber/modules/deposito/model/deposito.dart';
import 'package:bomber/modules/deposito/pages/deposito_abm.dart';
import 'package:bomber/modules/deposito/pages/deposito_lista_page.dart';
import 'package:bomber/modules/deposito/pages/deposito_reporte.dart';
import 'package:bomber/modules/deposito/pages/deposito_selector_page.dart';
import 'package:bomber/modules/deposito/repositories/deposito_respository.dart';
import 'package:bomber/modules/deposito/service/deposito_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DepositoModule extends Module {
  List<Module> get imports => [CiudadanoModule(), CoreModule()];

  @override
  void binds(i) {
    i.addSingleton(DepositoRespository.new);
    i.addSingleton(DepositoService.new);
    i.addSingleton(DepositoController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const DepositoListaPage());
    r.child('/abm_deposito', child: (_) => const DepositoAbm());
    r.child('/select', child: (_) => DepositoSelectorPage());
    r.child('/reporte_deposito', child: (_) => ReporteDeposito());
  }
}
