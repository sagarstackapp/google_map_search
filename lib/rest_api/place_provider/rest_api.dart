import 'dart:convert';

import 'package:google_map_search/model/suggestion_model.dart';
import 'package:http/http.dart';

class PlaceApiProvider {
  final client = Client();

  static final String apiKey = 'AIzaSyA7Wn3zak_R31Cada2rDYIWWeJjAK87RvY';

  Future<List<Suggestion>> fetchSuggestions(String input) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&components=country:ch&key=$apiKey';
    print('url --> $request');
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      print('Result --> $result');
      if (result['status'] == 'OK') {
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
