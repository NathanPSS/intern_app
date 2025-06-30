

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/window.dart';
import 'package:flutter_acrylic/window_effect.dart';
import 'package:intern_app/app/app_config.dart';
import 'package:intern_app/core/widgets/desktop_top_bar.dart';
import 'package:intern_app/core/widgets/main_area.dart';
import 'package:intern_app/core/widgets/menu_container.dart';
import 'package:provider/provider.dart';

void main() async {
  await windowConfig();
  runApp(App());
 
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: MaterialApp(
        theme: FlexThemeData.light(scheme: FlexScheme.blueM3,
          // Component theme configurations for light mode.
            useMaterial3: true,
          subThemesData: const FlexSubThemesData(
          interactionEffects: true,
          tintedDisabledControls: true,
          alignedDropdown: true,
          navigationRailUseIndicator: true,)),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          // Base background
          backgroundColor: Color(0xCC222222), //Color.fromRGBO(255, 255, 255, 0.8)
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomDesktopBar(),
              Row(
                children: [
                  MenuContainer(),
                  MainArea()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
