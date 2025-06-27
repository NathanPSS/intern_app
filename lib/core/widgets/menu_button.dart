
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
   const MenuButton({super.key, required this.icon, required this.nextScreenFunction});

   final Widget icon;

   final Function() nextScreenFunction;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: nextScreenFunction,
        style: ElevatedButton.styleFrom(
          elevation: 12,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(28), // controls the size
        ),
        child: icon
    );
  }
}