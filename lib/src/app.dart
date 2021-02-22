import 'package:flutter/material.dart';
import 'package:news/src/blocs/story_bloc.dart';
import 'package:news/src/screens/ui_news_list.dart';
import 'package:provider/provider.dart';

final storyBloc = StoryBloc();

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => storyBloc),
      ],
      child: MaterialApp(
        title: 'News!',
        home: UINewsList(),
      ),
    );
  }
}
