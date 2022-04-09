import 'package:flutter/material.dart';
import 'package:shrimp_app/models/Pond.dart';
import 'package:shrimp_app/services/LocalPondService.dart';
import 'package:shrimp_app/services/PondService.dart';

class EditPondsPageArguments {
  final String pondId;

  EditPondsPageArguments(this.pondId);
}

class EditPondPage extends StatefulWidget {
  static const String routeName = '/editPond';

  EditPondPage({Key? key}) : super(key: key);

  @override
  _EditPondPageState createState() => _EditPondPageState();
}

class _EditPondPageState extends State<EditPondPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final newNameController = TextEditingController();

  void _editPond(BuildContext context, String pondId) {
    if (_formKey.currentState!.validate()) {
      EditPondInput editPondInput =
          EditPondInput(pondId, newNameController.text, null, null);
      getPondService().editPond(editPondInput);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as EditPondsPageArguments;
    final pondToEdit = getPondService().getPond(args.pondId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit pond data'),
      ),
      body: FutureBuilder<Pond>(
          future: pondToEdit,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text('Loading ponds ....');
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  return Center(
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
                                          hintText: snapshot.data!.name),
                                    ),
                                  ])),
                        ]),
                  );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _editPond(context, args.pondId);
        },
        tooltip: 'Save update',
        child: Icon(Icons.save),
      ),
    );
  }
}
