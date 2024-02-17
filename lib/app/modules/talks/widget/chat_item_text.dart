
import 'package:flutter/material.dart';

class ChatTextView extends StatelessWidget {
  ChatTextView({super.key,this.content});

  String? content;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      // constraints: BoxConstraints(maxWidth: 0.7),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        content ?? "",
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
      ),
    );
  }
}
