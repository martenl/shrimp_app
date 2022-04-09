import 'package:flutter/material.dart';
import 'package:shrimp_app/models/Configuration.dart';

class ConfigurationInput extends StatefulWidget {
  final Configuration configuration;

  const ConfigurationInput({Key? key, required this.configuration})
      : super(key: key);

  @override
  State createState() => _ConfigurationInputState(configuration);
}

class _ConfigurationInputState extends State<ConfigurationInput> {
  final Configuration configuration;
  final GlobalKey<FormFieldState<String>> _nameFormFieldKey = GlobalKey();
  final GlobalKey<FormFieldState<String>> _salinityFormFieldKey = GlobalKey();
  late TextEditingController nameTextController;
  late TextEditingController salinityTextController;

  _notEmpty(String? value) => value != null && value.isNotEmpty;

  _saveConfiguration() {
    final newConfiguration = Configuration(nameTextController.text,
        double.tryParse(salinityTextController.text) ?? configuration.salinity);
    print(newConfiguration.toJson());
  }

  _ConfigurationInputState(this.configuration) {
    nameTextController = TextEditingController(text: configuration.name);
  }

  @override
  void initState() {
    super.initState();
    nameTextController = TextEditingController(text: configuration.name);
    salinityTextController =
        TextEditingController(text: configuration.salinity.toStringAsFixed(2));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameTextController.dispose();
    salinityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Text('Configuration', style: TextStyle(fontSize: 10),),
            subtitle: Form(
                child: Column(children: <Widget>[
              TextFormField(
                  key: _nameFormFieldKey,
                  controller: nameTextController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) => !_notEmpty(value)
                      ? 'A name for the pond is required'
                      : null),
              TextFormField(
                  key: _salinityFormFieldKey,
                  controller: salinityTextController,
                  decoration: InputDecoration(
                      labelText: 'Salinity level of the pond',
                      suffix: Text('ppt')),
                  validator: (value) => !_notEmpty(value)
                      ? 'A salinity level for the pond is required'
                      : null),
              ElevatedButton(
                  onPressed: _saveConfiguration,
                  child: Text("Save configuration"))
            ]))));
  }
}
