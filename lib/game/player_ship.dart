import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';

class PlayerShip extends PositionComponent {
  static final _paint = BasicPalette.magenta.paint();

  PlayerShip() {
    this.anchor = Anchor.center;
    this.size = Vector2.all(24);
  }

  @override
  void render(Canvas c) {
    super.render(c);

    c.drawRect(size.toRect(), _paint);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);

    this.x = gameSize.x / 2;
    this.y = gameSize.y - 32;
  }
}
