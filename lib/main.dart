import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lame_tank_360/lame-tank-360.dart';
import 'package:lame_tank_360/widgets/joypad.dart';

Future main() async {
  // set preferred orientations (landscape only)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // disable all UI overlays (show fullscreen)
  await SystemChrome.setEnabledSystemUIOverlays([]);

  // initialize a game first
  final LameTank360 game = LameTank360();

  // start app
  runApp(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: <Widget>[
          // placeholder for game
          game.widget,

          // joypad overlay
          Column(
            children: <Widget>[
              Spacer(),
              Row(
                children: <Widget>[
                  SizedBox(width: 48),
                  Joypad(
                    onChange: game.onLeftJoypadChange,
                  ),
                  Spacer(),
                  Joypad(
                    onChange: (Offset delta) => print(delta),
                  ),
                  SizedBox(width: 48),
                ],
              ),
              SizedBox(height: 24),
            ],
          ),
        ],
      ),
    ),
  );
}
