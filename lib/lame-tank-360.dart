import 'dart:ui';
import 'package:flame/game.dart';

class LameTank360 extends Game {
  Size screenSize;

  @override
  void render(Canvas c) {
    if (screenSize == null) {
      return; // just end execution if there's no screenSize
    }
  }

  @override
  void update(double t) {
    if (screenSize == null) {
      return; // just end execution if there's no screenSize
    }
  }

  @override
  void resize(Size size) {
    screenSize = size;
  }
}
