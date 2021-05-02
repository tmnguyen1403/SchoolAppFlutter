import 'package:flutter/material.dart';

class RowInfo extends StatelessWidget {
  final String label;
  final String content;

  RowInfo({required this.label, required this.content});

  @override
  Widget build(BuildContext context) {
     return Row(
       //mainAxisAlignment: MainAxisAlignment.center,
       children: [
        Expanded(
          flex: 1,
          child: Text(
            label,
            textAlign: TextAlign.center,
            
            style: TextStyle(
              color: Colors.blue[700], fontWeight: FontWeight.bold, fontSize: 30),
        )), 
        
        Expanded(
          child:Text(content, textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        ],
      );
  }
}