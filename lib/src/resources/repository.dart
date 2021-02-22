import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/news_api_provider.dart';
import 'package:news/src/resources/news_db_provider.dart';
import 'dart:async';

class Repository {
  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];
  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  //m1:
  //TODO: ITERATE SOURCES TO FETCH TOP IDS
  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  } //end of fetchTopIds method

  //m2:
  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    Source source;

    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) break;
    } //end for

    for (var cache in caches) {
      cache.addItem(item);
    } //end for

    return item;
  } //end of fetchItem method
} //end of Repository class

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
} //end of Source class

abstract class Cache {
  Future<int> addItem(ItemModel item);
} //end of Cache class
