import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  final List<String> items = [
    'Header',
    'Ammos',
    'Armors',
    'Ashes of War',
    'Bosses',
    'Classes',
    'Creatures',
    'Indications',
    'Items',
    'Locations',
    'NPCs',
    'Shields',
    'Sorceries',
    'Spirits',
    'Talismans',
    'Weapons',
  ];

  final String selected;

  NavDrawer({Key? key, required this.selected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: items.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              currentAccountPictureSize: Size.square(82.0),
              currentAccountPicture: Image.asset(
                'assets/elden_ring_logo.png',
                color: Colors.amber,
              ),
              accountName: Text('Elden Ring'),
              accountEmail: Text('Wiki app'),
            );
          } else {
            return ListTile(
              title: Text(items[index]),
              onTap: () {
                if (items[index] != selected) {
                  final route = items[index].toLowerCase();
                  Navigator.pushReplacementNamed(context, route);
                } else {
                  Navigator.pop(context);
                }
              },
            );
          }
        },
      ),
    );
  }
}
