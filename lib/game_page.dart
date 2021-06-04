import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:space_burger/game/invaders_game.dart';

class GamePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GamePageState();
  }
}

class _GamePageState extends State<GamePage> {
  int _credits = 2;
  bool _gameOver = false;
  InvadersGame? _game;

  void _play() {
    setState(() {
      _credits = _credits - 1;
      _gameOver = false;
      _game = InvadersGame(onGameOver: _onGameOver);
    });
  }

  void _onGameOver() {
    setState(() {
      _gameOver = true;
      _game = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final innerScreenBorderRadius = const BorderRadius.all(const Radius.circular(15));
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(25),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: innerScreenBorderRadius,
          ),
          child: _game != null
              ? ClipRRect(
                  borderRadius: innerScreenBorderRadius, 
                  child: GameWidget(game: _game!),
              )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_gameOver)
                      Text(
                          'Game Over!',
                          style: TextStyle(color: Colors.white, fontSize: 56),
                          textAlign: TextAlign.center,
                      ),
                      Text(
                          'Credits: $_credits',
                          style: TextStyle(color: Colors.white, fontSize: 42),
                      ),
                      if (_credits > 0)
                        ElevatedButton(
                            onPressed: _play,
                            child: Text('Play!'),
                        ),
                      // TODO(erick) implement insert credits
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
