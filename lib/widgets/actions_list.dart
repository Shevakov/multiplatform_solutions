import 'package:flutter/material.dart';

class ActionsList extends StatelessWidget {
  const ActionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Container(
          height: 50,
          color: Colors.white,
          child: const Center(child: Text('Посмотреть профиль')),
        ),
        const Divider(),
        Container(
          height: 50,
          color: Colors.white,
          child: const Center(child: Text('Посмотреть друзей')),
        ),
        const Divider(),
        Container(
          height: 50,
          color: Colors.white,
          child: const Center(child: Text('Сделать репорт данного человека')),
        ),
      ],
    );
  }
}
