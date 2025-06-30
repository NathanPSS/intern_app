import 'package:flutter/material.dart';
import 'package:intern_app/core/constants/window_constants.dart';

class RegistryBannerTop extends StatelessWidget {
  const RegistryBannerTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        //    top: 8,
        bottom: 8,
      ),
      width:
          windowDesktopAppWidth(context) -
          (windowDesktopAppWidth(context) * 0.16),
      height: windowDesktopAppHeight(context) * 0.136,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Registros",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 32,
            ),
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.primaryFixedDim,
                      width: 3,
                    ),
                  ),
                ),
                child: Text(
                  "Informações Básicas",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 24),
            ],
          ),
        ],
      ),
    );
  }
}
