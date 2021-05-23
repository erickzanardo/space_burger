import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'player_ship.dart';

class InvadersGame extends BaseGame with HasDraggableComponents {
  late PlayerShip player;

  @override
  Future<void> onLoad() async {
    add(player = PlayerShip());
  }
}
