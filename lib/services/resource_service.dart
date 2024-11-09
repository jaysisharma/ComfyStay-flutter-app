import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/resource.dart';

class ResourceService {
  final String baseUrl = 'http://localhost:5000/api/v1/resources';

  Future<List<Resource>> fetchResources() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body)['data']['resources'];
      return jsonData.map((json) => Resource.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load resources');
    }
  }
}
