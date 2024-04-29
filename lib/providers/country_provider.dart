import 'package:flutter/material.dart';
import 'package:lugares/models/country.dart';
import '../data/my_data.dart';

class CountryProvider extends ChangeNotifier {
  final List<Country> _countries = DUMMY_COUNTRIES.toList();

  List<Country> get countries => _countries;

  void addCountry(String title, Color color) {
    int id = int.parse(_countries.last.id.split('c')[1]) + 1;
    Country country =
        Country(id: 'c${id.toString()}', title: title, color: color);
    _countries.add(country);
    notifyListeners();
  }

  void removeCountry(String id) {
    _countries.removeWhere((country) => country.id == id);
    notifyListeners();
  }

  bool checkCountryExist(String identifier) {
    return _countries.any((country) =>
        country.id == identifier ||
        country.title.toLowerCase().trim() == identifier.toLowerCase().trim());
  }

  String getCountryNameById(String id) {
    return _countries.firstWhere((country) => country.id == id).title;
  }

  void updateCountry(
      {required String id, required String title, required Color color}) {
    int index = _countries.indexWhere((country) => country.id == id);
    if (index != -1) {
      Country tempCountry = Country(id: id, title: title, color: color);
      _countries[index] = tempCountry;
      notifyListeners();
    }
  }
}
