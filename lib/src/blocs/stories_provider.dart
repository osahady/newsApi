import 'package:flutter/material.dart';
import 'package:news/src/blocs/story_bloc.dart';
export 'story_bloc.dart';

class StoryProvider extends InheritedWidget {
  final StoryBloc bloc;

  StoryProvider({Key key, Widget child})
      : bloc = StoryBloc(),
        super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static StoryBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }
}
