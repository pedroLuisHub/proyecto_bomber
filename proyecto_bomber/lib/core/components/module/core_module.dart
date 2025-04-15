import 'package:bomber/core/components/dio/rest_client.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(i) {
    i.addSingleton(RestClient.new);
  }
}
