import 'dart:ui';
import 'package:flame/game.dart';
import 'package:lame_tank_360/components/bullet.dart';
import 'package:lame_tank_360/components/tank.dart';

class LameTank360 extends Game {
  Size screenSize;
  Tank tank;
  List<Bullet> bullets;

  @override
  void render(Canvas c) {
    if (screenSize == null) {
      return; // just end execution if there's no screenSize
    }

    // draw a grass field
    c.drawRect(
      Rect.fromLTWH(
        0,
        0,
        screenSize.width,
        screenSize.height,
      ),
      Paint()..color = Color(0xff27ae60),
    );

    // draw the tank
    tank.render(c);

    // draw bullets
    bullets.forEach((Bullet b) {
      b.render(c);
    });
  }

  @override
  void update(double t) {
    if (screenSize == null) {
      return; // just end execution if there's no screenSize
    }

    tank.update(t);

    // make bullets fly
    bullets.forEach((Bullet b) {
      b.update(t);
    });

    // remove off-screen bullets
    bullets.removeWhere((Bullet b) {
      return b.isOffscreen;
    });
  }

  @override
  void resize(Size size) {
    screenSize = size;

    if (tank == null) {
      tank = Tank(
        this,
        position: Offset(
          screenSize.width / 2,
          screenSize.height / 2,
        ),
      );
    }

    if (bullets == null) {
      bullets = List<Bullet>();
    }
  }

  void onLeftJoypadChange(Offset offset) {
    if (offset == Offset.zero) {
      tank.targetBodyAngle = null;
    } else {
      tank.targetBodyAngle = offset.direction;
    }
  }

  void onRightJoypadChange(Offset offset) {
    if (offset == Offset.zero) {
      tank.targetTurretAngle = null;
    } else {
      tank.targetTurretAngle = offset.direction;
    }
  }

  void onButtonTap() {
    bullets.add(
      Bullet(
        this,
        position: tank.getBulletOffset(),
        angle: tank.getBulletAngle(),
      ),
    );
  }
}
