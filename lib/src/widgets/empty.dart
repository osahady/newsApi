import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: false,
      child: Container(),
    );
  }
}
