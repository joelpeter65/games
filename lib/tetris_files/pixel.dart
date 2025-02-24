// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Pixel extends StatelessWidget {
  var color;
  var child;

  Pixel({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      margin: EdgeInsets.all(1),
    );
  }
}
