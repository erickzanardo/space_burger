import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'enemy_ship.dart';
import 'player_ship.dart';

final _r = Random();

class InvadersGame extends BaseGame
    with HasDraggableComponents, HasCollidables {
  late PlayerShip player;
  late TimerComponent enemySpawner;

  @override
  Future<void> onLoad() async {
    add(player = PlayerShip());
    add(
      enemySpawner = TimerComponent(
        Timer(0.5, repeat: true, callback: spawnEnemy)..start(),
      ),
    );
  }

  void spawnEnemy() {
    if (components.whereType<EnemyShip>().length > 20) {
      return;
    }

    final x = _r.nextDouble() * size.x;
    final y = -EnemyShip.shipSize;

    add(EnemyShip(Vector2(x, y)));
  }

  void gameOver() {
    clear();
    print('GAME OVER');
    // TODO(luan) impl game over
  }

  @override
  bool debugMode = true;
}
