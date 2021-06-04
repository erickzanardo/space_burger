import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

import 'bullet.dart';
import 'invaders_game.dart';
import 'player_ship.dart';

final _r = Random();

class EnemyShip extends SpriteAnimationComponent
    with Hitbox, Collidable, HasGameRef<InvadersGame> {
  static const shipSize = 50.0;
  static const shipSpeed = 10.0;

  late Timer bulletTimer;

  EnemyShip(Vector2 p) : super(position: p, size: Vector2.all(shipSize)) {
    anchor = Anchor.center;

    // just to make sure they don't endup too synced
    double timer = _r.nextDouble() / 2 + 0.5;
    bulletTimer = Timer(timer, repeat: true, callback: fire)..pause();

    addShape(HitboxRectangle());
  }

  @override
  Future<void> onLoad() async {
    animation = await gameRef.loadSpriteAnimation(
      'enemy.png',
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: 0.2,
        textureSize: Vector2.all(16),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    bulletTimer.update(dt);

    y += shipSpeed * dt;
    if (y > 0 && !bulletTimer.isRunning()) {
      bulletTimer.start();
    }

    if (y > gameRef.size.y) {
      gameRef.gameOver();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is PlayerShip) {
      gameRef.gameOver();
    }
  }

  void fire() {
    if (_r.nextDouble() >= 0.1) {
      return;
    }
    gameRef.add(
      Bullet(
        this,
        position + Vector2(0, size.y + Bullet.bulletSize) / 2,
        Vector2(0, 1) * Bullet.bulletSpeed,
      ),
    );
  }
}
