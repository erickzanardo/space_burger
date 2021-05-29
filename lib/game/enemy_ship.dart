import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';

import 'bullet.dart';
import 'invaders_game.dart';
import 'player_ship.dart';

class EnemyShip extends PositionComponent
    with Hitbox, Collidable, HasGameRef<InvadersGame> {
  static const shipSize = 36.0;
  static const shipSpeed = 10.0;
  static final _paint = BasicPalette.red.paint();

  late Timer bulletTimer;

  EnemyShip(Vector2 p) {
    position = p;
    anchor = Anchor.center;
    size = Vector2.all(shipSize);
    bulletTimer = Timer(0.5, repeat: true, callback: fire)..pause();

    addShape(HitboxRectangle());
  }

  @override
  void update(double dt) {
    super.update(dt);

    y += shipSpeed * dt;

    if (y > gameRef.size.y) {
      gameRef.gameOver();
    }
  }

  @override
  void render(Canvas c) {
    super.render(c);

    c.drawRect(size.toRect(), _paint);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is PlayerShip) {
      gameRef.gameOver();
    }
  }

  void fire() {
    gameRef.add(
      Bullet(
        position + Vector2(0, (size.y + Bullet.bulletSize) / 2 + 1),
        Vector2(0, 1) * Bullet.bulletSpeed,
      ),
    );
  }
}
