import 'package:flutter/material.dart';
import 'package:news/src/blocs/story_bloc.dart';
import 'package:provider/provider.dart';

class Refresh extends StatelessWidget {
  final Widget child;
  Refresh({this.child});
  @override
  Widget build(BuildContext context) {
    final storyBloc = Provider.of<StoryBloc>(context);
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await storyBloc.clearCache();
        await storyBloc.fetchTopIds();
      },
    );
  }
}
