import 'package:lugares/models/place.dart';
import 'package:flutter/material.dart';

class FavoritePlacesProvider extends ChangeNotifier {
  final List<Place> _favoritePlaces = [];

  void toggleFavorite(Place place) {
    _favoritePlaces.contains(place)
        ? _favoritePlaces.remove(place)
        : _favoritePlaces.add(place);
    notifyListeners();
  }

  bool isFavorite(Place place) {
    return _favoritePlaces.contains(place);
  }

  List<Place> get favoritePlaces => _favoritePlaces;
}
