import 'dart:convert';

import 'package:shrimp_app/models/Dimension.dart';
import 'package:shrimp_app/models/Measurement.dart';

import 'Configuration.dart';

enum Mode {
  manual,
  eco
}

class Pond {
  Pond(this.id, this.name, this.lastMeasurement, this.mode, this.configuration, this.pondDimension);

  final String id;
  final String name;
  final Configuration configuration;
  final PondDimension pondDimension;
  final Mode mode;
  final Measurement lastMeasurement;

  Object toJson() {
    return {
      "id": id,
      "name": name,
      "mode": mode.toString(),
      "configuration": configuration.toJson(),
      "dimension": pondDimension.toJson(),
      "lastMeasurement": lastMeasurement.toJson()
    };
  }

  static Pond fromMap(data) {
    String id = data['id'];
    Configuration configuration = Configuration.fromMap(data['pondConfiguration']);
    String name = configuration.name;
    PondDimension pondDimension = PondDimension.fromMap(data['pondDimension']);
    Measurement lastMeasurement = Measurement.fromMap(data['lastMeasurement']);
    Mode mode = Mode.manual;
    return Pond(id, name, lastMeasurement, mode, configuration, pondDimension);
  }

  static Pond fromJson(String json) {
    Map<String, dynamic> data = jsonDecode(json);
    return fromMap(data);
  }
}

class CreatePondInput {
  final String name;
  final Configuration? configuration;
  final PondDimension? pondDimension;

  CreatePondInput(this.name, this.configuration, this.pondDimension);
}

class EditPondInput {
  final String id;
  final String newName;
  final Configuration? configuration;
  final PondDimension? pondDimension;

  EditPondInput(this.id, this.newName, this.configuration, this.pondDimension);

  Object toJson() {
    return {
      "id": id,
      "newName": newName,
      "updatedConfiguration": configuration != null ? configuration!.toJson() : null,
      "updatedPondDimension": pondDimension != null ? pondDimension!.toJson() : null
    };
  }
}
