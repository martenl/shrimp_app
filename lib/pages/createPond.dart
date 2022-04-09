import 'package:flutter/material.dart';
import 'package:shrimp_app/models/Pond.dart';
import 'package:shrimp_app/services/LocalPondService.dart';
import 'package:shrimp_app/services/PondService.dart';
import 'package:shrimp_app/widgets/AppDrawer.dart';

class CreatePond extends StatelessWidget {
  void _newPond(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create new pond")),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('You have pushed the button this many times:'),
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Back to the first route'))
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _newPond(context),
        tooltip: 'Add Pond',
        child: Icon(Icons.add),
      ),
    );
  }
}

class CreatePondPage extends StatefulWidget {
  CreatePondPage({Key? key}) : super(key: key);

  static const String routeName = '/createPond';

  @override
  _CreatePondPageState createState() => _CreatePondPageState();
}

class _CreatePondPageState extends State<CreatePondPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final newNameController = TextEditingController();

  void _createPond(BuildContext context) {
    CreatePondInput createPondInput = CreatePondInput(newNameController.text, null, null);
    getPondService().createPond(createPondInput);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new pond'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: newNameController,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter the name of the pond'),
                      ),
                    ])),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _createPond(context);
          }
        },
        tooltip: 'Add Pond',
        child: Icon(Icons.save),
      ),
    );
  }
}
