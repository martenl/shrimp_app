import 'package:flutter/material.dart';
import 'package:shrimp_app/models/Dimension.dart';
import 'package:shrimp_app/models/Pond.dart';
import 'package:shrimp_app/services/RestPondService.dart';

class DimensionInput extends StatefulWidget {
  final PondDimension dimension;

  const DimensionInput({Key? key, required this.dimension}) : super(key: key);

  @override
  _DimensionInputState createState() => _DimensionInputState(dimension);
}

class _DimensionInputState extends State<DimensionInput> {
  final PondDimension dimension;
  late TextEditingController widthTextController;
  late TextEditingController lengthTextController;
  late TextEditingController depthTextController;
  late int selectedShapeIndex;
  final List<bool> selectedShape = [false, false, false];
  final List<Widget> shapeItems = createShapeItems();

  late int selectedSlopeIndex;
  final List<bool> selectedSlope = [false, false, false];
  final List<Widget> slopeItems = createSlopeItems();

  _DimensionInputState(this.dimension);

  @override
  void initState() {
    super.initState();
    selectedShapeIndex = this.dimension.shape.index;
    selectedShape[this.dimension.shape.index] = true;
    selectedSlopeIndex = this.dimension.slope.index;
    selectedSlope[this.dimension.slope.index] = true;
    widthTextController =
        TextEditingController(text: dimension.width.toStringAsFixed(2));
    lengthTextController =
        TextEditingController(text: dimension.length.toStringAsFixed(2));
    depthTextController =
        TextEditingController(text: dimension.depth.toStringAsFixed(2));
  }

  @override
  void dispose() {
    widthTextController.dispose();
    lengthTextController.dispose();
    depthTextController.dispose();
    super.dispose();
  }

  _selectShape(int index) {
    selectedShapeIndex = index;
    for (int i = 0; i < selectedSlope.length; i++) {
      selectedShape[i] = i == index;
    }
    setState(() {});
  }

  _selectSlope(int index) {
    selectedSlopeIndex = index;
    for (int i = 0; i < selectedSlope.length; i++) {
      selectedSlope[i] = i == index;
    }
    setState(() {});
  }

  _saveDimension() {
    final shape = Shape.values[selectedShapeIndex];
    final slope = Slope.values[selectedSlopeIndex];
    final length = double.parse(lengthTextController.text);
    final width = double.parse(widthTextController.text);
    final depth = double.parse(depthTextController.text);

    final newDimension = PondDimension(width, length, depth, shape, slope);
    var editPondInput = EditPondInput(
        '60f0815239d4b17079b8c333', 'My pond', null, newDimension);
    RestPondService.getPondService().editPond(editPondInput);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Text(
              'Dimension of pond',
              style: TextStyle(fontSize: 10),
            ),
            subtitle: Form(
                child: Column(children: [
              Text('Shape of the pond'),
              ToggleButtons(
                children:
                    shapeItems,
                isSelected: selectedShape,
                onPressed: _selectShape,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              Text('Slope of the pond'),
              ToggleButtons(
                children: slopeItems,
                isSelected: selectedSlope,
                onPressed: _selectSlope,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              TextFormField(
                //key: _nameFormFieldKey,
                controller: lengthTextController,
                decoration: InputDecoration(
                    labelText: 'Length of pond', suffix: Text('m')),
                /*validator: (value) => !_notEmpty(value)
                          ? 'A name for the pond is required'
                          : null*/
              ),
              TextFormField(
                //key: _nameFormFieldKey,
                controller: widthTextController,
                decoration: InputDecoration(
                    labelText: 'Width of pond', suffix: Text('m')),
                /*validator: (value) => !_notEmpty(value)
                          ? 'A name for the pond is required'
                          : null*/
              ),
              TextFormField(
                //key: _nameFormFieldKey,
                controller: depthTextController,
                decoration: InputDecoration(
                    labelText: 'Depth of pond', suffix: Text('m')),
                /*validator: (value) => !_notEmpty(value)
                          ? 'A name for the pond is required'
                          : null*/
              ),
              ElevatedButton(
                  onPressed: _saveDimension, child: Text('Save dimensions'))
            ]))));
  }
}

List<Text> createShapeItems() {
  return Shape.values
      .map((e) => e.toString().replaceAll('Shape.', ''))
      .map((e) => capitalize(e))
      .map((e) => Text(e))
      .toList();
}

List<Text> createSlopeItems() {
  return Slope.values
      .map((e) => e.toString().replaceAll('Slope.', ''))
      .map((e) => capitalize(e))
      .map((e) => Text(e))
      .toList();
}

String capitalize(String e) {
  return "${e[0].toUpperCase()}${e.substring(1)}";
}
