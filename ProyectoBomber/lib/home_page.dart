import 'package:bomber/custom_buttom_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 226, 14, 14),
        title: Text(
          "Bienvenido",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
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
                  SizedBox(height: 70,),//SIRVE PARA DEJAR UN ESPACIO, ES UN WIDGET Y PUEDE TENER CONTENIDO.
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 15,
                    children: [
                      CustomButtomWidget(
                        label: 'Registrar Bombero',
                        // child: Image.asset('assets/images/registro_bombero.png'),
                        icon: Icons.person_add,
                        onPressed: () {},
                      ),
                      CustomButtomWidget(
                        iconColor: const Color.fromARGB(255, 57, 216, 8),
                        label: 'Buscar Puntos Recarga',
                        icon: Icons.inventory_2,
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
                        iconColor: Colors.orangeAccent,
                        label: 'Tacticas Combate',
                        icon: Icons.local_fire_department,
                        onPressed: () {},
                      ),
                    
                      CustomButtomWidget(
                        iconColor: Colors.red,
                        label: 'Moviles Operativos',
                        icon: Icons.airport_shuttle,
                        onPressed: () {},
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
