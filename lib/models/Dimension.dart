
enum Shape {
  rectangle,
  triangle,
  elipse
}

enum Slope {
  gentle,
  slanted,
  straight
}

class PondDimension {
  PondDimension(this.width, this.length, this.depth, this.shape, this.slope);

  final double width;
  final double length;
  final double depth;
  final Shape shape;
  final Slope slope;

  Object toJson() {
    return {
      "width": width,
      "length": length,
      "depth": depth,
      "shape": shape.toString().replaceAll('Shape.', '').toUpperCase(),
      "slope": slope.toString().replaceAll('Slope.', '').toUpperCase()
    };
  }

  static PondDimension fromMap(data) {
    if(data == null) {
      return PondDimension(0.0, 0.0, 0.0, Shape.rectangle, Slope.gentle);
    }
    double width = data['width'];
    double length = data['length'];
    double depth = data['depth'];
    Shape shape = Shape.values.firstWhere((e) => e.toString() == 'Shape.' + data['shape'].toLowerCase());
    Slope slope = Slope.values.firstWhere((e) =>  e.toString() == 'Slope.' + data['slope'].toLowerCase());
    return PondDimension(width, length, depth, shape, slope);
  }
}