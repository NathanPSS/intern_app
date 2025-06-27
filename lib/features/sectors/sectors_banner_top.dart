import 'package:flutter/material.dart';
import 'package:intern_app/core/constants/window_constants.dart';
import 'package:intern_app/features/user/widgets/user_search.dart';

class SectorsBannerTop extends StatelessWidget {
  const SectorsBannerTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      width:
      windowDesktopAppWidth(context) -
          (windowDesktopAppWidth(context) * 0.2),
      height: windowDesktopAppHeight(context) * 0.136,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Setores",
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
                            width: 3
                        ))),
                child: Text(
                  "Informações Básicas",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
