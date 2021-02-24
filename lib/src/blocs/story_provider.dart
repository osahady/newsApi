import 'package:flutter/material.dart';
import 'package:news/src/blocs/story_bloc.dart';
export 'story_bloc.dart';

class StoryProvider extends InheritedWidget {
  final StoryBloc storyBloc;

  StoryProvider({Key key, Widget child})
      : storyBloc = StoryBloc(),
        super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static StoryBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StoryProvider>().storyBloc;
  }
}
