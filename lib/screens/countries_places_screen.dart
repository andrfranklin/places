import 'package:lugares/components/place_item.dart';
import 'package:lugares/models/country.dart';
import 'package:flutter/material.dart';
import 'package:lugares/providers/place_provider.dart';
import 'package:provider/provider.dart';

class CountryPlacesScreen extends StatelessWidget {
  //Country country;
  // CountryPlacesScreen(this.country);
  late PlaceProvider placeProvider;

  @override
  Widget build(BuildContext context) {
    final country = ModalRoute.of(context)!.settings.arguments as Country;
    placeProvider = Provider.of<PlaceProvider>(context);

    print('id: ${country.id}');
    print(placeProvider.places.map((e) => ({e.titulo, e.paises.toString()})));

    final countryPlaces = placeProvider.places.where((places) {
      return places.paises.contains(country.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(country.title),
      ),
      body: ListView.builder(
          itemCount: countryPlaces.length,
          itemBuilder: (ctx, index) {
            return PlaceItem(countryPlaces[index]);
          }),
    );
  }
}
