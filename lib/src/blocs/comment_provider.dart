import 'package:flutter/material.dart';
import 'package:news/src/blocs/comment_bloc.dart';
export 'comment_bloc.dart';

class CommentProvider extends InheritedWidget {
  final CommentBloc commentsProvider;

  CommentProvider({Key key, Widget child})
      : commentsProvider = CommentBloc(),
        super(child: child, key: key);

  bool updateShouldNotify(_) => true;

  static CommentBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }
}
