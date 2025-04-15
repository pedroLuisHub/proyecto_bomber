import 'package:flutter/material.dart';

class AppBarPrincipal extends StatelessWidget implements PreferredSizeWidget {

    final String text;

  const AppBarPrincipal({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 226, 14, 14),
      title: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
