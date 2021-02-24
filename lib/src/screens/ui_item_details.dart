import 'package:flutter/material.dart';

class UIItemDetails extends StatelessWidget {
  final int itemId;

  UIItemDetails({this.itemId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text('details'),
        ),
        body: pageBody(),
      ),
    );
  }

  Widget pageBody() {
    return Center(child: Text('$itemId'));
  }
}
