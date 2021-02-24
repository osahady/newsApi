import 'package:flutter/material.dart';
import 'package:news/src/blocs/story_bloc.dart';
import 'package:news/src/screens/ui_item_details.dart';
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
        onGenerateRoute: routes,
      ),
    );
  } //end of build method

  //m1:
  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) {
        return UINewsList();
      });
    } else {
      return MaterialPageRoute(builder: (context) {
        //fetch data here is perfect
        final itemId = int.parse(settings.name.replaceFirst('/', ''));
        return UIItemDetails(itemId: itemId);
      });
    }
  }
}
