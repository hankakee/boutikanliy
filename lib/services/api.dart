import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  static Future<dynamic> get(String url, dynamic apiheaders) async {
    dynamic response = "";
    if (apiheaders != null) {
      print("Nou gen header bro");
      response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ' + apiheaders,
        },
      );
    } else {
      // print("Nou pa gen header");
      response = await http.get(Uri.parse(url));
    }
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print("Gen erè ki pase");
      return "no ";
    }
  }

  static Future<dynamic> post(String url, {required Map body}) async {
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      print("Gen erè ki pase");
    }
  }
}
