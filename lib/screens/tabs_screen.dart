import 'package:flutter/material.dart';
import 'package:lugares/providers/favorite_places_provider.dart';
import 'package:provider/provider.dart';

import '../components/main_drawer.dart';
import 'countries_screen.dart';
import 'favorite_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _indexSelectedScreen = 0;
  late FavoritePlacesProvider favoritePlacesProvider;

  late List<Widget> _screens;
  final List<String> _titles = [
    'Lista de Lugares',
    'Meus Favoritos',
  ];

  _selectScreen(int index) {
    setState(() {
      _indexSelectedScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    favoritePlacesProvider = Provider.of<FavoritePlacesProvider>(context);

    _screens = [
      CountriesScreen(),
      FavoriteScreen(favoritePlacesProvider.favoritePlaces)
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_indexSelectedScreen],
        ),
      ),
      body: _screens[_indexSelectedScreen],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.white,
        currentIndex: _indexSelectedScreen,
        backgroundColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Países'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritos'),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
