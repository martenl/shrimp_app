import 'dart:convert';

import 'package:shrimp_app/models/Pond.dart';

import 'PondService.dart';
import 'dart:io';

import 'package:http/http.dart' as http;

class RestPondService extends PondService {
  HttpClient httpClient = HttpClient();
  static const String apiBaseUrl =
      //'https://6105ad064b92a000171c5fc2.mockapi.io/api/v1/';
      'http://192.168.178.48:8089';

  static PondService _pondService = RestPondService();

  static PondService getPondService() {
    return _pondService;
  }

  @override
  Future<Pond> createPond(CreatePondInput createPondInput) {
    // TODO: implement createPond
    throw UnimplementedError();
  }

  @override
  Future<Pond> editPond(EditPondInput editPondInput) {
    var id = editPondInput.id;
    return http
        .patch(
          Uri.parse('$apiBaseUrl/pond/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(editPondInput),
        )
        .then((value) => Pond.fromJson(value.body));
  }

  @override
  Future<Pond> getPond(String id) {
    return http
        .get(Uri.parse('$apiBaseUrl/pond/$id'))
        .then((value) => Pond.fromJson(value.body));
  }

  @override
  Future<Iterable<Pond>> getPonds(int page) {
    return http.get(Uri.parse('$apiBaseUrl/pond?page=$page')).then((response) {
      if (response.statusCode == 200) {
        Iterable l = json.decode(response.body);
        return List<Pond>.from(l.map((model) => Pond.fromMap(model)));
      }
      return List.empty();
    });
  }

  RestPondService() {
    httpClient.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  }
}
