import 'package:shrimp_app/models/Pond.dart';
import 'package:shrimp_app/services/LocalPondService.dart';

abstract class PondService {
  Future<Iterable<Pond>> getPonds(int page);
  Future<Pond> getPond(String id);
  Future<Pond> createPond(CreatePondInput createPondInput);
  Future<Pond> editPond(EditPondInput editPondInput);
}

PondService getPondService() {
  return LocalPondService();
}