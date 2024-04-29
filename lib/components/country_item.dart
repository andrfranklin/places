import 'package:flutter/material.dart';
import 'package:lugares/models/country.dart';
import 'package:lugares/screens/country_registration.dart';

class CountryItem extends StatelessWidget {
  final Country country;
  final bool? manager;

  const CountryItem(this.country, {this.manager});

  void _selectedCountry(BuildContext context) {
    /*
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return CountryPlacesScreen(country);
    }));
    */
    Navigator.of(context).pushNamed(
      '/country-places',
      arguments: country,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool luminance = country.color.computeLuminance() > 0.45;
    return InkWell(
      onTap: () => _selectedCountry(context),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
                colors: [
                  country.color.withOpacity(0.5),
                  country.color, //cor passada
                ],
                begin: Alignment.topLeft, //inicio do gradiente
                end: Alignment.bottomRight // fim
                )),
        child: Stack(
          children: [
            Text(
              country.title,
              style: Theme.of(context).textTheme.headline6,
            ),
            if (manager ?? false)
              Positioned(
                left: -15,
                bottom: -15,
                child: IconButton(
                  icon: Icon(Icons.delete,
                      color: (luminance) ? Colors.grey.shade700 : Colors.white),
                  onPressed: () {},
                ),
              ),
            if (manager ?? false)
              Positioned(
                right: -15,
                bottom: -15,
                child: IconButton(
                  icon: Icon(Icons.edit,
                      color: (luminance) ? Colors.grey.shade700 : Colors.white),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: CountryRegistration(
                            initialCountry: country,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
