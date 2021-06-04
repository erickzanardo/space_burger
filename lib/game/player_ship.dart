import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/gestures.dart';

import 'bullet.dart';
import 'invaders_game.dart';

class PlayerShip extends SpriteAnimationComponent
    with Draggable, Hitbox, Collidable, HasGameRef<InvadersGame> {
  Vector2? dragStart;
  late Timer bulletTimer;

  PlayerShip() : super(size: Vector2.all(48)) {
    anchor = Anchor.center;
    bulletTimer = Timer(0.5, repeat: true, callback: fire)..pause();

    addShape(HitboxRectangle());
  }

  @override
  Future<void> onLoad() async {
    animation = await gameRef.loadSpriteAnimation(
      'player.png',
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
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);

    x = gameSize.x / 2;
    y = gameSize.y - 64;
  }

  @override
  bool onDragStart(int pointerId, DragStartInfo info) {
    bulletTimer.start();
    return super.onDragStart(pointerId, info);
  }

  @override
  bool onDragEnd(int pointerId, DragEndInfo info) {
    bulletTimer.pause();
    return super.onDragEnd(pointerId, info);
  }

  @override
  bool onDragCancel(int pointerId) {
    bulletTimer.pause();
    return super.onDragCancel(pointerId);
  }

  @override
  bool onDragUpdate(int pointerId, DragUpdateInfo info) {
    final ds = info.delta.game;
    position.x += ds.x;
    position.x = position.x.clamp(0, gameRef.size.x);
    return true;
  }

  void fire() {
    gameRef.add(
      Bullet(
        this,
        position - Vector2(0, size.y + Bullet.bulletSize) / 2,
        Vector2(0, -1) * Bullet.bulletSpeed,
      ),
    );
  }
}
