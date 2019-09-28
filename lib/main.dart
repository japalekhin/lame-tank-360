import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lame_tank_360/widgets/joypad.dart';

Future main() async {
  // set preferred orientations (landscape only)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // disable all UI overlays (show fullscreen)
  await SystemChrome.setEnabledSystemUIOverlays([]);

  // start app
  runApp(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: <Widget>[
          // placeholder for game
          Container(
            color: Color(0xff27ae60),
          ),

          // joypad overlay
          Column(
            children: <Widget>[
              Spacer(),
              Row(
                children: <Widget>[
                  SizedBox(width: 48),
                  Joypad(
                    onChange: (Offset delta) => print(delta),
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
