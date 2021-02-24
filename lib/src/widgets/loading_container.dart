import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: buildContianer(),
          subtitle: buildContianer(),
        ),
        Divider(height: 8.0),
      ],
    );
  }

  Widget buildContianer() {
    return Container(
      color: Colors.grey[200],
      width: 150,
      height: 24,
    );
  }
}
