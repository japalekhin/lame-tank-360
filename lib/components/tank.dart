import 'dart:math';
import 'dart:ui';
import 'package:lame_tank_360/lame-tank-360.dart';

class Tank {
  final LameTank360 game;
  Offset position = Offset.zero;
  double bodyAngle = 0;
  double turretAngle = 0;
  double targetBodyAngle;
  double targetTurretAngle;

  Tank(this.game, {this.position});

Offset getBulletOffset() {
  return position +
      Offset.fromDirection(
        getBulletAngle(),
        36,
      );
}

double getBulletAngle() {
  double bulletAngle = bodyAngle + turretAngle;
  while (bulletAngle > pi) {
    bulletAngle -= pi * 2;
  }
  while (bulletAngle < -pi) {
    bulletAngle += pi * 2;
  }
  return bulletAngle;
}

  void render(Canvas c) {
    // prepare some paint objects
    Paint lightPaint = Paint()..color = Color(0xffdddddd);
    Paint darkPaint = Paint()..color = Color(0xff777777);

    // set the canvas origin onto the tank position
    c.save();
    c.translate(position.dx, position.dy);

    // rotate the whole tank
    c.rotate(bodyAngle);

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

    // rotate the turret
    c.rotate(turretAngle);

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

  void update(double t) {
    final double rotationRate = pi * t;

    if (targetBodyAngle != null) {
      if (bodyAngle == targetBodyAngle) {
        position = position + Offset.fromDirection(bodyAngle, 100 * t);
      } else {
        position = position + Offset.fromDirection(bodyAngle, 50 * t);
      }

      if (bodyAngle < targetBodyAngle) {
        if ((targetBodyAngle - bodyAngle).abs() > pi) {
          bodyAngle = bodyAngle - rotationRate;
          if (bodyAngle < -pi) {
            bodyAngle += pi * 2;
          }
        } else {
          bodyAngle = bodyAngle + rotationRate;
          if (bodyAngle > targetBodyAngle) {
            bodyAngle = targetBodyAngle;
          }
        }
      }
      if (bodyAngle > targetBodyAngle) {
        if ((targetBodyAngle - bodyAngle).abs() > pi) {
          bodyAngle = bodyAngle + rotationRate;
          if (bodyAngle > pi) {
            bodyAngle -= pi * 2;
          }
        } else {
          bodyAngle = bodyAngle - rotationRate;
          if (bodyAngle < targetBodyAngle) {
            bodyAngle = targetBodyAngle;
          }
        }
      }
    }

    if (targetTurretAngle != null) {
      double localTargetTurretAngle = targetTurretAngle - bodyAngle;
      if (turretAngle < localTargetTurretAngle) {
        if ((localTargetTurretAngle - turretAngle).abs() > pi) {
          turretAngle = turretAngle - rotationRate;
          if (turretAngle < -pi) {
            turretAngle += pi * 2;
          }
        } else {
          turretAngle = turretAngle + rotationRate;
          if (turretAngle > localTargetTurretAngle) {
            turretAngle = localTargetTurretAngle;
          }
        }
      }
      if (turretAngle > localTargetTurretAngle) {
        if ((localTargetTurretAngle - turretAngle).abs() > pi) {
          turretAngle = turretAngle + rotationRate;
          if (turretAngle > pi) {
            turretAngle -= pi * 2;
          }
        } else {
          turretAngle = turretAngle - rotationRate;
          if (turretAngle < localTargetTurretAngle) {
            turretAngle = localTargetTurretAngle;
          }
        }
      }
    }
  }
}
