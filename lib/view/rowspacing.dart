import 'package:flutter/material.dart';

class RowSpacing extends StatelessWidget {
  final Widget contentWidget;
  RowSpacing({required this.contentWidget});

  @override
  Widget build(BuildContext context) {
    return
     Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[
         Spacer(flex:4),
         Expanded(
           flex: 2,
           child: contentWidget,
        ),
        Spacer(flex: 4),
    ],);
  }
}