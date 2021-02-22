import 'package:flutter/material.dart';
import 'package:news/src/app.dart';
import 'package:news/src/blocs/story_bloc.dart';
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
      body: pageBody(),
    );
  }

  Widget pageBody() {
    return buildList(storyBloc);
  }

  Widget buildList(StoryBloc storyBloc) {
    return FutureBuilder<List<int>>(
        future: storyBloc.fetchTopIds(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Waiting();
          return ListView.separated(
            itemBuilder: (context, index) {
              final id = snapshot.data[index];
              return Text('hello $index: $id');
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: snapshot.data.length,
          );
        });
  }
}
