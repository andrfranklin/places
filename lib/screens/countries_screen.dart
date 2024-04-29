import 'package:lugares/components/country_item.dart';
import 'package:flutter/material.dart';
import 'package:lugares/components/main_drawer.dart';
import 'package:lugares/providers/country_provider.dart';
import 'package:lugares/screens/country_registration.dart';
import 'package:provider/provider.dart';

class CountriesScreen extends StatelessWidget {
  late CountryProvider countryProvider;
  bool? manager;

  CountriesScreen({super.key, this.manager});
  @override
  Widget build(BuildContext context) {
    countryProvider = Provider.of<CountryProvider>(context);
    return Scaffold(
      appBar: manager == null
          ? null
          : AppBar(
              title: const Text(
              'Gestão de países',
            )),
      floatingActionButton: manager == null
          ? null
          : FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: CountryRegistration(),
                    );
                  },
                );
              },
              child: const Icon(Icons.add),
            ),
      drawer: MainDrawer(),
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent:
              200, //cada elemento com extenso maxima de 200 pixel
          childAspectRatio: 3 / 2, //proporcao de cada elemento dentro do grid
          crossAxisSpacing: 20, //espacamento no eixo cruzado
          mainAxisSpacing: 20, //espacamento no eixo principal
        ),
        children: countryProvider.countries.map((country) {
          return CountryItem(country, manager: manager ?? false);
        }).toList(),
      ),
    );
  }
}
