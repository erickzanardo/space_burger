import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';

import 'invaders_game.dart';

class PlayerShip extends PositionComponent
    with Draggable, HasGameRef<InvadersGame> {
  static final _paint = BasicPalette.magenta.paint();

  Vector2? dragStart;

  PlayerShip() {
    anchor = Anchor.center;
    size = Vector2.all(48);
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

  bool onDragUpdate(int pointerId, DragUpdateInfo info) {
    final ds = info.delta.game;
    position.x += ds.x;
    position.x = position.x.clamp(0, gameRef.size.x);
    return true;
  }
}
