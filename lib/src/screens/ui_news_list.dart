import 'package:flutter/material.dart';
import 'package:news/src/blocs/story_bloc.dart';
import 'package:news/src/blocs/story_provider.dart';
import 'package:news/src/widgets/news_list_tile.dart';
import 'package:news/src/widgets/refresh.dart';
import 'package:news/src/widgets/waiting.dart';
import 'package:provider/provider.dart';

class UINewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storyBloc = Provider.of<StoryBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: pageBody(storyBloc),
    );
  }

  Widget pageBody(StoryBloc storyBloc) {
    return buildList(storyBloc);
  }

  Widget buildList(StoryBloc storyBloc) {
    //BAD DO NOT DO THIS!!
    //IT WILL BE CALLED ON
    //EVERY BUILD OF THE WIDGET
    storyBloc.fetchTopIds(); //لحقن التيار بالقيم

    return StreamBuilder<List<int>>(
        stream: storyBloc.topIds,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Waiting();

          return Refresh(
            child: ListView.separated(
              itemBuilder: (context, index) {
                final id = snapshot.data[index];
                storyBloc.fetchItem(id);
                return NewsListTile(itemId: id);
              },
              separatorBuilder: (context, index) => Divider(height: 8.0),
              itemCount: snapshot.data.length,
            ),
          );
        });
  }
}
