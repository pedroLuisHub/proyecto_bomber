import 'package:bomber/core/ui/app_bar/app_bar_principal.dart';
import 'package:bomber/core/ui/buttons/custom_buttom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: AppBarPrincipal(text: "Bienvenido"),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.red),
              child: Text(
                'Menú',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ExpansionTile(
              leading: Icon(Icons.person),
              title: Text('Bomberos'),
              children: [
                ListTile(
                  title: Text('Registrar Bombero'),
                  onTap: () {
                    Modular.to.pushNamed('/bombero/abm_bombero');
                  },
                ),
                ListTile(
                  title: Text('Lista de Bomberos'),
                  onTap: () {
                    Modular.to.pushNamed('/bombero/');
                  },
                ),
              ],
            ),

            ExpansionTile(
              leading: Icon(Icons.fire_truck_sharp),
              title: Text('Moviles'),
              children: [
                ListTile(
                  title: Text('Registrar Movil'),
                  onTap: () {
                    Modular.to.pushNamed('/movil/abm_movil');
                  },
                ),
                ListTile(
                  title: Text('Lista de Moviles'),
                  onTap: () {
                    Modular.to.pushNamed('/movil/');
                  },
                ),
              ],
            ),
                        ExpansionTile(
              leading: Icon(Icons.fire_truck_sharp),
              title: Text('Ciudadanos'),
              children: [
                ListTile(
                  title: Text('Registrar Ciudadano'),
                  onTap: () {
                    Modular.to.pushNamed('/ciudadano/abm_ciudadano');
                  },
                ),
                ListTile(
                  title: Text('Lista de Ciudadanos'),
                  onTap: () {
                    Modular.to.pushNamed('/ciudadano/');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: _builBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Configuracion",
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }

  Widget _builBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 700,
            child: Image.asset(
              'assets/images/bomber_foto.png',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                  ), //SIRVE PARA DEJAR UN ESPACIO, ES UN WIDGET Y PUEDE TENER CONTENIDO.
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 15,
                    children: [
                      CustomButtomWidget(
                        label: 'Registrar Bombero',
                        // child: Image.asset('assets/images/registro_bombero.png'),
                        icon: Icons.person_add,
                        onPressed: () {
                          Modular.to.pushNamed('/bombero/abm_bombero');
                        },
                      ),

                      CustomButtomWidget(
                        iconColor: const Color.fromARGB(255, 68, 108, 219),
                        label: 'Buscar Puntos Recarga',
                        icon: Icons.water_drop,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 15,
                    children: [
                      CustomButtomWidget(
                        iconColor: const Color.fromARGB(255, 255, 1, 1),
                        label: 'Tácticas Combate',
                        icon: Icons.fire_extinguisher,
                        onPressed: () {},
                      ),

                      CustomButtomWidget(
                        iconColor: Colors.red,
                        label: 'Móviles Operativos',
                        icon: Icons.fire_truck_sharp,
                        onPressed: () {
                          Modular.to.pushNamed('/movil/abm_movil');
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
