import 'dart:async';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CommentBloc {
  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  CommentBloc() {
    _commentsFetcher.stream.transform(_commentsTransformer()).pipe(_commentsOutput);
  }

  //stream
  Stream<Map<int, Future<ItemModel>>> get itemWithComments => _commentsOutput.stream;
  //sink
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  //transformer
  _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      //accumulator callback
      (cache, int id, index) {
        cache[id] = _repository.fetchItem(id);
        cache[id].then((itemModel) => itemModel.kids.forEach((kidId) {
              fetchItemWithComments(kidId);
            }));
        return cache;
      },

      //seed
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
} //end of CommentBloc class
