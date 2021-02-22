import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class StoryBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _items = BehaviorSubject<int>();

  StoryBloc() {
    _items.stream.transform(_itemsTransformer());
  }
  Stream<Map<int, Future<ItemModel>>> items;
  Stream<List<int>> get topIds => _topIds.stream;
  Function(int) get fetchItems => _items.sink.add;

  Future<List<int>> fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    return ids;
    // _topIds.sink.add(ids);
  }

  dispose() {
    _topIds.close();
    _items.close();
  } //end of dispose method

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, _) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }
} //end of StoryBloc class
