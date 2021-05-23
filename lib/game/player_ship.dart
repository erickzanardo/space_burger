import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';

class PlayerShip extends PositionComponent {
  static final _paint = BasicPalette.magenta.paint();

  PlayerShip() {
    anchor = Anchor.center;
    size = Vector2.all(24);
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
    y = gameSize.y - 32;
  }
}
