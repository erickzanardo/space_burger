import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';

import 'bullet.dart';
import 'invaders_game.dart';

class PlayerShip extends PositionComponent
    with Draggable, Hitbox, Collidable, HasGameRef<InvadersGame> {
  static final _paint = BasicPalette.magenta.paint();

  Vector2? dragStart;
  late Timer bulletTimer;

  PlayerShip() {
    anchor = Anchor.center;
    size = Vector2.all(48);
    bulletTimer = Timer(0.5, repeat: true, callback: fire)..pause();

    addShape(HitboxRectangle());
  }

  @override
  void update(double dt) {
    super.update(dt);

    bulletTimer.update(dt);
  }

  @override
  void render(Canvas c) {
    super.render(c);

    c.drawRect(size.toRect(), _paint);
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
        position - Vector2(0, (size.y + Bullet.bulletSize) / 2 + 1),
        Vector2(0, -1) * Bullet.bulletSpeed,
      ),
    );
  }
}
