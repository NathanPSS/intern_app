import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:intern_app/core/constants/window_constants.dart';

class CustomDesktopBar extends StatelessWidget {
  const CustomDesktopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: windowDesktopAppWidth(context) * 0.2,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.transparent,
          
          ),
        ),
        Container(
          width: windowDesktopAppWidth(context) * 0.8,
          //    margin: EdgeInsets.only(left: windowDesktopAppWidth(context) * 0.2),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            border: Border(bottom: BorderSide(color: Colors.white, width: 1.5)),
          ),
          height: 48,
          child: Row(
            children: [
              Expanded(child: MoveWindow()),
              MinimizeWindowButton(),
              MaximizeWindowButton(),
              CloseWindowButton(),
            ],
          ),
        ),
      ],
    );
  }
}
