import 'dart:convert';

import 'package:shrimp_app/models/Configuration.dart';
import 'package:shrimp_app/models/Dimension.dart';
import 'package:shrimp_app/models/Measurement.dart';
import 'package:shrimp_app/models/Pond.dart';
import 'package:shrimp_app/services/PondService.dart';

class LocalPondService extends PondService {
  static PondService _pondService = LocalPondService();

  static PondService getPondService() {
    return _pondService;
  }

  var idMatches = (id) => (element) => element.id == id;
  final List<Pond> ponds = List.from([
    new Pond(
        '0',
        'My cool pond',
        Measurement(23.0, 6.0, 0.01),
        Mode.eco,
        Configuration('Test pond 1', 20.0),
        PondDimension(10.0, 15.0, 5.0, Shape.rectangle, Slope.slanted)),
    new Pond(
        '1',
        'My cool second pond',
        Measurement(23.0, 6.0, 0.01),
        Mode.manual,
        Configuration('Test pond 1', 20.0),
        PondDimension(10.0, 15.0, 5.0, Shape.rectangle, Slope.slanted))
  ]);

  @override
  Future<Pond> createPond(CreatePondInput createPondInput) {
    final String id = ponds.length.toString();
    final Pond newPond = Pond(
        id,
        createPondInput.name,
        Measurement(0.0, 0.0, 0.0),
        Mode.manual,
        Configuration('Test pond 1', 20.0),
        PondDimension(10.0, 15.0, 5.0, Shape.rectangle, Slope.slanted));
    ponds.add(newPond);
    return Future.value(newPond);
  }

  @override
  Future<Pond> editPond(EditPondInput editPondInput) {
    var _idMatches = idMatches(editPondInput.id);
    var pondToEdit = ponds.where(_idMatches);
    var idx = ponds.indexWhere(_idMatches);
    if (pondToEdit.isEmpty) return Future.error('No pond with id');
    var currentPond = pondToEdit.first;
    final Pond newPond = Pond(
        editPondInput.id,
        editPondInput.newName,
        currentPond.lastMeasurement,
        currentPond.mode,
        currentPond.configuration,
        currentPond.pondDimension);
    ponds[idx] = newPond;
    return Future.value(newPond);
  }

  @override
  Future<Pond> getPond(String id) {
    var _idMatches = idMatches(id);
    return Future.value(ponds.where(_idMatches).first);
  }

  @override
  Future<Iterable<Pond>> getPonds(int page) {
    //if(page*5 > po)
    return Future.value(ponds);
  }
}
