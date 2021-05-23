import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';

import 'invaders_game.dart';
import 'simple_draggable.dart';

class PlayerShip extends PositionComponent
    with Draggable, SimpleDraggable, HasGameRef<InvadersGame> {
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

  @override
  void handleDragMovement(Vector2 ds) {
    position.x += ds.x;
    position.x = position.x.clamp(0, gameRef.size.x);
  }
}
