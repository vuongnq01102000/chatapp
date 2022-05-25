import 'package:flutter/material.dart';

class TabBarHomePage extends StatelessWidget {
  const TabBarHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.chat_bubble)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.store)),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chat_bubble_outline_rounded)),
        const Spacer(),
        Container(
          color: Colors.grey[200],
          width: double.infinity,
          height: 60,
          padding: const EdgeInsets.all(8.0),
          child: const CircleAvatar(
              maxRadius: 15,
              minRadius: 10,
              backgroundImage: AssetImage('assets/avt.jpeg')),
        ),
      ],
    );
  }
}
