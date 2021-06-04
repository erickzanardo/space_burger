import 'package:flutter/material.dart';
import 'package:space_burger/game_page.dart';
import 'package:space_burger/widgets/arcade_call_to_action.dart';
import 'package:space_burger/widgets/quick_action_card.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Image.asset('assets/logo.png'),
            ),
          ),
          Text(
            'Space Burger',
            style: Theme.of(context).textTheme.headline2,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(25),
                  topRight: const Radius.circular(25),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    ArcadeCallToAction(openGame: () {
                      showDialog(
                          context: context,
                          builder: (context) => GamePage(),
                      );
                    }),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          QuickActionCard(
                            label: 'Cardápio',
                            icon: Icons.fastfood_sharp,
                          ),
                          QuickActionCard(
                            label: 'Cupons',
                            icon: Icons.book_online_sharp,
                          ),
                          QuickActionCard(
                            label: 'Restaurantes',
                            icon: Icons.local_restaurant_sharp,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
