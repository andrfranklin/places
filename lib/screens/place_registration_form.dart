import 'package:flutter/material.dart';
import 'package:lugares/components/main_drawer.dart';
import 'package:lugares/models/country.dart';
import 'package:lugares/providers/country_provider.dart';
import 'package:lugares/providers/place_provider.dart';
import 'package:provider/provider.dart';

class PlaceRegistrationForm extends StatefulWidget {
  const PlaceRegistrationForm({super.key});

  @override
  PlaceRegistrationFormState createState() => PlaceRegistrationFormState();
}

class PlaceRegistrationFormState extends State<PlaceRegistrationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late CountryProvider countryProvider;
  late PlaceProvider placeProvider;
  List<String> _selectedCountries = [];
  String? _title;
  String? _imageUrl;
  List<String> _recommendations = [];
  String? _recommendation;
  double? _rating;
  double? _averageCost;

  void _submitData() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print("Países selecionados: $_selectedCountries");
      print("Título: $_title");
      print("URL da imagem: $_imageUrl");
      print("Recomendações: $_recommendations");
      print("Avaliação: $_rating");
      print("Custo médio: $_averageCost");

      placeProvider.addPlace(
          paises: _selectedCountries.toList(),
          titulo: _title!,
          imagemUrl: _imageUrl!,
          recomendacoes: _recommendations.toList(),
          avaliacao: _rating!,
          custoMedio: _averageCost!);

      setState(() {
        _selectedCountries.clear();
        _title = null;
        _imageUrl = null;
        _recommendations.clear();
        _recommendation = null;
        _rating = null;
        _averageCost = null;
      });

      Navigator.of(context).pushReplacementNamed('/');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lugar cadastrado com sucesso')));
    }
  }

  @override
  Widget build(BuildContext context) {
    countryProvider = Provider.of<CountryProvider>(context);
    placeProvider = Provider.of<PlaceProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar lugar'),
      ),
      drawer: MainDrawer(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            DropdownButtonFormField<String>(
              onChanged: (value) {
                if (value == null) return;
                _selectedCountries.add(value);
                setState(() {
                  _selectedCountries = _selectedCountries;
                });
              },
              hint: const Text('Selecione um país'),
              items: [
                ...countryProvider.countries
                    .map<DropdownMenuItem<String>>((Country country) {
                  return DropdownMenuItem<String>(
                      value: country.id, child: Text(country.title));
                }).toList(),
              ],
              validator: (value) {
                if (_selectedCountries.isEmpty) {
                  return 'Por favor, selecione pelo menos um país.';
                }
                return null;
              },
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _selectedCountries.map<Widget>((countryId) {
                  String countryName =
                      countryProvider.getCountryNameById(countryId);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: OutlinedButton(
                      child: Text(countryName),
                      onPressed: () {
                        setState(() {
                          _selectedCountries.remove(countryId);
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            TextFormField(
                decoration: const InputDecoration(
                  label: Text('Título'),
                ),
                onSaved: (value) {
                  _title = value!.trim();
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, insira um título.';
                  }
                  return null;
                }),
            TextFormField(
                decoration: const InputDecoration(
                  label: Text('URL da imagem'),
                ),
                onSaved: (value) {
                  _imageUrl = value!.trim();
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, insira a URL da imagem.';
                  }
                  return null;
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Recomendações'),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _recommendation = value.trim();
                      });
                    },
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.add),
                    onPressed:
                        _recommendation == null || _recommendation!.isEmpty
                            ? null
                            : () {
                                String formattedRecommendation =
                                    _recommendation!.trim().toLowerCase();
                                if (_recommendations.any((element) =>
                                    element.toLowerCase() ==
                                    formattedRecommendation)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('A recomendação já existe'),
                                    ),
                                  );
                                  return;
                                }
                                setState(() {
                                  _recommendations.add(_recommendation!.trim());
                                  _recommendation = null;
                                });
                              }),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: _recommendations.asMap().entries.map<Widget>((entry) {
                  int index = entry.key;
                  String recommendation = entry.value;
                  return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 30),
                    ),
                    child: Text('${index + 1}. $recommendation'),
                    onPressed: () {
                      setState(() {
                        _recommendations.removeAt(index);
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            TextFormField(
                decoration: const InputDecoration(
                  label: Text('Avaliação'),
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _rating = double.tryParse(value!);
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, entre com a avaliação.';
                  }

                  double? rating = double.tryParse(value);
                  if (rating == null) {
                    return 'Por favor, entre com um valor numérico.';
                  } else if (rating < 0 || rating > 5) {
                    return 'Por favor, entre com um valor entre 0 e 5.';
                  }

                  return null;
                }),
            TextFormField(
                decoration: const InputDecoration(
                  label: Text('Custo médio'),
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _averageCost = double.tryParse(value!);
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, entre com o custo médio.';
                  }

                  try {
                    double.parse(value);
                  } catch (error) {
                    return 'Por favor, entre com um valor numérico.';
                  }

                  return null;
                }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
