import 'dart:convert';

class Measurement {
  Measurement(this.temperature, this.ph, this.oxygenSaturation);

  final double temperature;
  final double ph;
  final double oxygenSaturation;

  Object toJson() {
    return {"temperature": temperature, "ph": ph, "oxygenSaturation": oxygenSaturation};
  }

  static Measurement fromMap(data) {
    if(data == null) {
      return Measurement(0.0, 0.0, 0.0);
    }
    return Measurement(data['temperature'], data['ph'], data['oxygenSaturation']);
  }

  static Measurement fromJson(String json) {
    Map<String, dynamic> data = jsonDecode(json);
    return fromMap(data);
  }
}
