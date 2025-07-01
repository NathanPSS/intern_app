import 'package:flutter/material.dart';
import 'package:intern_app/core/constants/window_constants.dart';
import 'package:intern_app/core/widgets/menu_button.dart';
import 'package:provider/provider.dart';

import 'main_area.dart';

class MenuContainer extends StatelessWidget {
  const MenuContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      alignment: Alignment.centerLeft,
      width: windowDesktopAppWidth(context) * 0.2,
      height: windowDesktopAppHeight(context) - 48,
      child: Padding(
        padding: const EdgeInsets.only(left: 56),
        child: Column(
          children: [
            Image.asset("assets/imgs/logo.png", width: 160, height: 48),
            SizedBox(height: 48),
            SizedBox(
              height: windowDesktopAppHeight(context) * 0.72,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MenuButton(
                    icon: Image.asset(
                      "assets/imgs/group.png",
                      width: 44,
                      height: 44,
                    ),
                    nextScreenFunction: () {
                      Provider.of<NavigationProvider>(
                        context,
                        listen: false,
                      ).navigateToScreen({'screen': 'users'});
                    },
                  ),
                  MenuButton(
                    icon: Image.asset(
                      "assets/imgs/report.png",
                      width: 44,
                      height: 44,
                    ),
                    nextScreenFunction: () {
                      Provider.of<NavigationProvider>(
                        context,
                        listen: false,
                      ).navigateToScreen({'screen': 'registry'});
                    },
                  ),
                  MenuButton(
                    icon: Image.asset(
                      "assets/imgs/pie-chart.png",
                      width: 44,
                      height: 44,
                    ),
                    nextScreenFunction: () {
                      Provider.of<NavigationProvider>(
                        context,
                        listen: false,
                      ).navigateToScreen({'screen': 'sectors'});
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
