import 'package:lugares/providers/country_provider.dart';
import 'package:lugares/providers/favorite_places_provider.dart';
import 'package:flutter/material.dart';
import 'package:lugares/providers/place_provider.dart';
import 'package:lugares/screens/countries_places_screen.dart';
import 'package:lugares/screens/countries_screen.dart';
import 'package:lugares/screens/place_detail_screen.dart';
import 'package:lugares/screens/place_registration_form.dart';
import 'package:lugares/screens/settings_screen.dart';
import 'package:lugares/screens/tabs_screen.dart';
import 'package:lugares/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<FavoritePlacesProvider>(
            create: (context) => FavoritePlacesProvider(),
          ),
          ChangeNotifierProvider<CountryProvider>(
            create: (context) => CountryProvider(),
          ),
          ChangeNotifierProvider<PlaceProvider>(
            create: (context) => PlaceProvider(),
          )
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlacesToGo',
      theme: ThemeData(
        colorScheme: ThemeData()
            .colorScheme
            .copyWith(primary: Colors.purple, secondary: Colors.amber),
        fontFamily: 'Raleway',
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      //home: CountriesScreen(),
      initialRoute: '/',
      routes: {
        AppRoutes.HOME: (ctx) => const TabsScreen(),
        AppRoutes.COUNTRY_PLACES: (ctx) => CountryPlacesScreen(),
        AppRoutes.PLACES_DETAIL: (ctx) => PlaceDetailScreen(),
        AppRoutes.SETTINGS: (ctx) => SettingsScreen(),
        AppRoutes.PLACE_REGISTRATION_FORM: (ctx) => PlaceRegistrationForm(),
        AppRoutes.COUNTRY_PLACES_MANAGEMENT: (ctx) => CountriesScreen(
              manager: true,
            ),
      },
    );
  }
}
