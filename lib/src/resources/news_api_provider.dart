import 'dart:convert';
import 'package:http/http.dart';
import 'package:news/src/models/item_model.dart';

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    String url = '$_root/topstories.json';
    final response = await client.get(url);
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    String url = '$_root/item/$id.json';
    final response = await client.get(url);
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}
