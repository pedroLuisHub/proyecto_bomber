import 'package:flutter/material.dart';

class InputSearchDelegate<T> extends StatelessWidget {
  final String label;
  final SearchDelegate<T> searchDelegate;
  final TextEditingController controller;
  final void Function(T?)? onSelected;
  final void Function()? onLongPress;
  final bool enabled;

  const InputSearchDelegate({
    super.key,
    required this.label,
    required this.searchDelegate,
    required this.controller,
    this.onSelected,
    this.enabled = true,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: () async {
        if (enabled) {
          final data = await showSearch(
            context: context,
            delegate: searchDelegate,
          );

          if (data != null) {
            onSelected!(data);
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200], // Fondo gris claro
          borderRadius: BorderRadius.circular(16), // Bordes redondeados
          border: Border.all(color: Colors.grey[300]!, width: 1), // Borde sutil
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            // Icono de búsqueda a la izquierda
            Icon(Icons.search, color: Colors.grey[600]),
            const SizedBox(width: 8),
            // Campo de texto que simula el TextField desactivado
            Expanded(
              child: Text(
                controller.text.isEmpty ? label : controller.text,
                style: TextStyle(
                  color:
                      controller.text.isEmpty ? Colors.grey[600] : Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            // Icono de cierre a la derecha
            if (controller.text.isNotEmpty)
              IconButton(
                onPressed: () {
                  if (enabled) {
                    controller.clear();
                    if (onSelected != null) onSelected!(null);
                  }
                },
                icon: Icon(Icons.close, color: Colors.red[300]),
              ),
          ],
        ),
      ),
    );
  }
}
