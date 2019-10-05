import 'dart:ui';
import 'package:lame_tank_360/lame-tank-360.dart';

class Tank {
  final LameTank360 game;
  Offset position = Offset.zero;
  double bodyAngle = 0;
  double turretAngle = 0;

  Tank(this.game, {this.position});

  void render(Canvas c) {
    // prepare some paint objects
    Paint lightPaint = Paint()..color = Color(0xffdddddd);
    Paint darkPaint = Paint()..color = Color(0xff777777);

    // set the canvas origin onto the tank position
    c.save();
    c.translate(position.dx, position.dy);

    // draw tank body
    c.drawRect(
      Rect.fromLTWH(-20, -15, 40, 30),
      lightPaint,
    );

    // draw wheels
    c.drawRect(
      Rect.fromLTWH(-24, -23, 48, 8),
      darkPaint,
    );
    c.drawRect(
      Rect.fromLTWH(-24, 15, 48, 8),
      darkPaint,
    );

    // draw turret
    c.drawRect(
      Rect.fromLTWH(-10, -12, 25, 24),
      darkPaint,
    );
    c.drawRect(
      Rect.fromLTWH(0, -3, 36, 6),
      darkPaint,
    );
    c.drawRect(
      Rect.fromLTWH(36, -5, 6, 10),
      darkPaint,
    );

    c.restore();
  }

  void update(double t) {}
}
