import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';

import 'enemy_ship.dart';
import 'invaders_game.dart';
import 'player_ship.dart';

class Bullet extends PositionComponent
    with Hitbox, Collidable, HasGameRef<InvadersGame> {
  static const bulletSize = 4.0;
  static const bulletSpeed = 350.0;
  static final _paint = BasicPalette.green.paint();

  Component owner;
  Vector2 velocity;

  Bullet(this.owner, Vector2 p, this.velocity) {
    anchor = Anchor.center;
    position = p;
    size = Vector2.all(bulletSize);

    addShape(HitboxCircle());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += velocity * dt;

    if (!gameRef.size.toRect().containsPoint(position)) {
      remove();
    }
  }

  @override
  void render(Canvas c) {
    super.render(c);
    c.drawCircle(Offset.zero, bulletSize / 2, _paint);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other == owner) {
      return;
    } else if (other is PlayerShip) {
      gameRef.gameOver();
    } else if (other is EnemyShip) {
      remove();
      other.remove();
    }
  }
}
