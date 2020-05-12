import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task/models/dataModel.dart';

Future<List<DataModel>> makeGetRequest() async {
  String url = "https://jsonplaceholder.typicode.com/posts";
  var request = await http.get(Uri.parse(url));

  if (request.statusCode == 200) {
    List<DataModel> results = [];
    List incomingData = json.decode(request.body) as List;

    try {
      results = incomingData.map((e) => DataModel.fromJSON(e)).toList();
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
    return results;
  } else {
    throw Exception('Failed to make request!');
  }
}
