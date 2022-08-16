import 'package:flutter/material.dart';

import '../person.dart';

class PersonCard extends StatelessWidget {
  final Person person;
  final bool isWide;
  final Function(BuildContext) onTap;

  const PersonCard(
      {Key? key,
      required this.person,
      required this.isWide,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: isWide
            ? Column(
                children: [
                  const CircleAvatar(
                    child: Icon(
                      Icons.person,
                    ),
                  ),
                  Text(person.name),
                  Text(person.email),
                ],
              )
            : Column(children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(person.name),
                  subtitle: Text(person.email),
                )
              ]),
      ),
      onTap: () {
        onTap(context);
      },
    );
  }
}
