import 'package:flutter/material.dart';

class GenericButton extends StatelessWidget {
  const GenericButton({super.key, required this.text, required this.buttonWidth, required this.buttonHeight});

  final String text;
  final double buttonWidth;
  final double buttonHeight;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(buttonWidth, buttonHeight),
          backgroundColor: Color.fromRGBO(89, 76, 239, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // 🟦 Rounded corners
          ),
        ),
        onPressed: () {debugPrint("dasd");},
        child: Text(text, style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w200)),
      );
  }
}
