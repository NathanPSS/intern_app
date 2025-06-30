
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';

Future<void> windowConfig () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Window.initialize();
   await Window.setEffect(
    effect: WindowEffect.aero,
    color:  Color.fromRGBO(255, 255, 255, 0.5)
  );
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(1280,720);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.centerLeft;
    win.title = "App";
    MinimizeWindowButton();
    MaximizeWindowButton();
    CloseWindowButton();
    win.show();
  });
}