import 'package:flutter/material.dart';
import 'package:news/src/blocs/story_bloc.dart';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/widgets/empty.dart';
import 'package:news/src/widgets/loading_container.dart';
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
          if (!snapshot.hasData) return Loading();
          final futureItem = snapshot.data[itemId];

          return FutureBuilder<ItemModel>(
              future: futureItem,
              builder: (context, itemSnapshot) {
                if (!itemSnapshot.hasData) if (itemSnapshot.data != null) return Loading();
                final item = itemSnapshot.data;

                return item != null ? buildTile(context, item) : Empty();
              });
        });
  } //end of build method

  Widget buildTile(BuildContext context, ItemModel item) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, '/${item.id}');
      },
      title: Text(item?.title),
      subtitle: Text('${item?.score} points'),
      trailing: Column(
        children: [
          Icon(Icons.comment),
          Text(item.descendants.toString()),
        ],
      ),
    );
  } //end of buildTile method
} //end of NewsListTile class
