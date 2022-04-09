class Configuration {
  Configuration(this.name, this.salinity);

  final String name;
  final double salinity;

  Object toJson() {
    return {
      "name": name,
      "salinity": salinity
    };
  }

  static Configuration fromMap(data) {
    if(data == null) {
      return Configuration("", 0.0);
    }
    final double salinity = data['salinity'];
    final String name = data['name'];
    return Configuration(name, salinity);
  }
}
