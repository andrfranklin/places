import 'package:flutter/material.dart';
import 'package:lugares/models/place.dart';
import '../data/my_data.dart';

class PlaceProvider extends ChangeNotifier {
  final List<Place> _places = DUMMY_PLACES.toList();

  List<Place> get places => _places;

  void addPlace(
      {required List<String> paises,
      required String titulo,
      required String imagemUrl,
      required List<String> recomendacoes,
      required double avaliacao,
      required double custoMedio}) {
    int id = _places.length + 1;
    Place place = Place(
        id: 'p${id.toString()}',
        paises: paises,
        titulo: titulo,
        imagemUrl: imagemUrl,
        recomendacoes: recomendacoes,
        avaliacao: avaliacao,
        custoMedio: custoMedio);
    _places.add(place);
    notifyListeners();
  }

  void removePlace(String id) {
    _places.removeWhere((country) => country.id == id);
    notifyListeners();
  }
}
