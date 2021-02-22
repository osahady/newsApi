import 'package:flutter/material.dart';
import 'package:news/src/blocs/story_bloc.dart';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/widgets/waiting.dart';
import 'package:provider/provider.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;
  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final storyBloc = Provider.of<StoryBloc>(context);

    return StreamBuilder<Map<int, Future<ItemModel>>>(
        stream: storyBloc.items,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Waiting();
          final futureItem = snapshot.data[itemId];
          return FutureBuilder<ItemModel>(
              future: futureItem,
              builder: (context, itemSnapshot) {
                if (!itemSnapshot.hasData) return Waiting();
                final item = itemSnapshot.data;
                return Text('${item.title}');
              });
        });
  } //end of build method
} //end of NewsListTile class
