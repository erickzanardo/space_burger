import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'enemy_ship.dart';
import 'player_ship.dart';

final _r = Random();

class InvadersGame extends BaseGame
    with HasDraggableComponents, HasCollidables {
  final VoidCallback onGameOver;
  late PlayerShip player;
  late TimerComponent enemySpawner;
  bool isGameOver = false;

  InvadersGame({
    required this.onGameOver,
  });

  @override
  Future<void> onLoad() async {
    add(player = PlayerShip());
    add(
      enemySpawner = TimerComponent(
        Timer(0.5, repeat: true, callback: spawnEnemy)..start(),
      ),
    );
  }

  @override
  void update(double dt) {
    if (isGameOver) {
      return;
    }
    super.update(dt);
  }

  void spawnEnemy() {
    final ships = components.whereType<EnemyShip>();
    if (ships.length > 10) {
      return;
    }

    // try 10 times to find a spot
    for (var i = 0; i < 10; i++) {
      final x = _r.nextDouble() * size.x;
      if (ships.every((e) => !_overlapsShip(e.x, x))) {
        final y = -EnemyShip.shipSize;
        add(EnemyShip(Vector2(x, y)));
        return;
      }
    }
  }

  void gameOver() {
    clear();
    print('GAME OVER');
    isGameOver = true;
    onGameOver();
  }

  bool _overlapsShip(double x1, double x2) {
    final start1 = x1 - EnemyShip.shipSize / 2;
    final end1 = x1 + EnemyShip.shipSize / 2;
    final start2 = x2 - EnemyShip.shipSize / 2;
    final end2 = x2 + EnemyShip.shipSize / 2;
    return end1 > start2 && start1 < end2;
  }
}
