import 'package:bomber/core/components/api/host_name.dart';
import 'package:bomber/modules/app_module.dart';
import 'package:bomber/modules/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(430, 900), // Tamaño inicial (similar a un celular)
    minimumSize: Size(360, 640), // Tamaño mínimo
    maximumSize: Size(700, 1080), // Opcional, para que no se agrande demasiado
    center: true,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.setResizable(
      true,
    ); // Para evitar que el usuario lo cambie
  });
  // runApp(const MyApp());
  await Hostname.instance.init();
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
