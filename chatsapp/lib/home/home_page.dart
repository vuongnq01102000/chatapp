import 'package:chatsapp/page/row1/tab_bar_home_page.dart';
import 'package:chatsapp/page/row2/list_contact.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: 100,
              color: Colors.grey[400]!.withOpacity(0.8),
              child: const TabBarHomePage(),
            ),
          ),
          Expanded(
              flex: 4,
              child: Container(
                color: Colors.green,
                child: const ListContact(),
              )),
          Expanded(
              flex: 10,
              child: Container(
                color: Colors.red,
              )),
        ],
      ),
    );
  }
}
