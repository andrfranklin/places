import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:lugares/models/country.dart';
import 'package:lugares/providers/country_provider.dart';
import 'package:provider/provider.dart';

class CountryRegistration extends StatefulWidget {
  final Country? initialCountry;
  const CountryRegistration({super.key, this.initialCountry});

  @override
  CountryRegistrationState createState() => CountryRegistrationState();
}

class CountryRegistrationState extends State<CountryRegistration> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late CountryProvider countryProvider;
  late String? _countryName;
  late Color _currentColor;

  @override
  void initState() {
    super.initState();
    if (widget.initialCountry != null) {
      _countryName = widget.initialCountry!.title;
      _currentColor = widget.initialCountry!.color;
    } else {
      _countryName = null;
      _currentColor = Colors.grey;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.initialCountry != null) {
        countryProvider.updateCountry(
            id: widget.initialCountry!.id,
            title: _countryName!,
            color: _currentColor);
      } else {
        countryProvider.addCountry(_countryName!, _currentColor);
      }
      setState(() {
        _countryName = null;
        _currentColor = Colors.grey;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    countryProvider = Provider.of<CountryProvider>(context);
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      title: const Text("Cadastrar país"),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                initialValue: _countryName,
                decoration: const InputDecoration(
                  label: Text('Nome do País'),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, digite o nome do país';
                  }
                  if (widget.initialCountry == null &&
                      countryProvider.checkCountryExist(value)) {
                    return 'País já existe';
                  }
                  return null;
                },
                onSaved: (value) {
                  _countryName = value;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ColorPicker(
                pickerColor: _currentColor,
                onColorChanged: (Color color) {
                  setState(() {
                    _currentColor = color;
                  });
                },
                pickerAreaHeightPercent: 0.8,
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
