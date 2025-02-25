import 'package:flutter/material.dart';

class CustomButtomWidget extends StatelessWidget {
  final String label;
  final Widget? child;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback onPressed;
  final Color? foregroundColor;

  const CustomButtomWidget({
    super.key,
    required this.label,
    this.icon,
    this.child,
    required this.onPressed,
    this.foregroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  width: 180.0,
                  height: 180.0,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  // child: SizedBox(
                  //   child: child ?? Icon(icon, size: 40,)),
                   child: Icon(icon, color: iconColor, size: 60.0),
                ),
              ),
            ],
          ),
        ),
        Text(label, style: TextStyle(letterSpacing: 0.0, fontSize: 18)),
      ],
    );
  }
}
