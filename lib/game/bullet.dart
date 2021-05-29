import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';

import 'enemy_ship.dart';
import 'invaders_game.dart';
import 'player_ship.dart';

class Bullet extends PositionComponent
    with Hitbox, Collidable, HasGameRef<InvadersGame> {
  static const bulletSize = 4.0;
  static const bulletSpeed = 400.0;
  static final _paint = BasicPalette.green.paint();

  Vector2 velocity;

  Bullet(Vector2 p, this.velocity) {
    anchor = Anchor.center;
    position = p;
    size = Vector2.all(bulletSize);

    addShape(HitboxCircle());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += velocity * dt;
  }

  @override
  void render(Canvas c) {
    super.render(c);
    c.drawCircle(Offset.zero, bulletSize / 2, _paint);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is PlayerShip) {
      gameRef.gameOver();
    } else if (other is EnemyShip) {
      remove();
      other.remove();
    }
  }
}
