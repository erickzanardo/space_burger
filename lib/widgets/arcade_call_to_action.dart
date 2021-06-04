import 'package:flutter/material.dart';

class ArcadeCallToAction extends StatelessWidget {
  final VoidCallback openGame;

  ArcadeCallToAction({ required this.openGame });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(5),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.videogame_asset_sharp,
                  size: 100,
                  color: Theme.of(context).primaryColorDark,
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                    children: [
                      Text(
                        'Space burger arcade!',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(height: 10),
                      Text(
                          'Proteja a terra contra invasores extraterrestres e ganhe prêmios!',
                          textAlign: TextAlign.center,
                      ),
                    ],
                  ),),
                ),
              ],
            ),
            ElevatedButton(
              child: Text('Jogue agora'),
              onPressed: openGame,
            ),
          ],
        ),
      ),
    );
  }
}
