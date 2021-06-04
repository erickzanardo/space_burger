import 'package:flutter/material.dart';

class QuickActionCard extends StatelessWidget {
  final String label;
  final IconData icon;

  QuickActionCard({
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 120,
        height: 120,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Icon(
                  icon,
                  color: Theme.of(context).accentColor,
                  size: 70,
                ),
              ),
              Text(label, style: Theme.of(context).textTheme.bodyText2),
            ],
          ),
        ),
      ),
    );
  }
}
