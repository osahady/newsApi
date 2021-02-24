import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class StoryBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();

  StoryBloc() {
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  } //end of constructor

  //getters
  Stream<List<int>> get topIds => _topIds.stream;
  Stream<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  //setters
  Function(int) get fetchItem => _itemsFetcher.sink.add;

  //m1:
  Future<List<int>> fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
    return ids;
    // _topIds.sink.add(ids);
  }

  //m2:
  clearCache() {
    return _repository.clearCache();
  }

  dispose() {
    _topIds.close();
    _itemsOutput.close();
    _itemsFetcher.close();
  } //end of dispose method

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, index) {
        print('This is called $index times');
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  } //end of _itemsTransformer method
} //end of StoryBloc class
