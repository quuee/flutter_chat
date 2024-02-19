
// 群聊界面 展示群聊列表

import 'package:flutter/material.dart';

class ContactGroupView extends StatelessWidget {
  const ContactGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('群聊'),
      actions: [IconButton(onPressed: (){}, icon: Icon(Icons.search))],),
      body: SafeArea(
        child: ListView.builder(itemBuilder: (context,index){

        }),
      ),
    );
  }
}

