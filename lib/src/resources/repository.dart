import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/news_api_provider.dart';
import 'package:news/src/resources/news_db_provider.dart';

class Repository {
  NewsApiProvider apiProvider = NewsApiProvider();
  NewsDbProvider dbProvider = NewsDbProvider();

  //m1:
  Future<List<int>> fetchTopIds() {
    return apiProvider.fetchTopIds();
  } //end of fetchTopIds method

  //m2:
  Future<ItemModel> fetchItem(int id) async {
    var item = await dbProvider.fetchItem(id);
    if (item != null) return item;

    item = await apiProvider.fetchItem(id);
    dbProvider.addItem(item);
    return item;
  } //end of fetchItem method
} //end of Repository class
