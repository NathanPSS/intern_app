
import 'package:flutter/material.dart';

class BannerTopButton extends StatelessWidget{
  const BannerTopButton({super.key, required this.text, required this.seleted, required this.nextScreenFunction});

  final String text;

  final bool seleted;

  final GestureTapCallback nextScreenFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: nextScreenFunction,
      hoverColor: Colors.blueAccent,
      child: Container(
        decoration: BoxDecoration(
            border: seleted ? Border(
                bottom: BorderSide(
                    color: Theme.of(context).colorScheme.primaryFixedDim,
                    width: 3
                )) : null ),
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}