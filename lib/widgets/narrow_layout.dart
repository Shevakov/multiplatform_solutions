import 'package:flutter/material.dart';

import '../person.dart';
import 'actions_list.dart';
import 'person_card.dart';

class NarrowLayout extends StatelessWidget {
  final List<Person> persons;

  const NarrowLayout({Key? key, required this.persons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: persons.length,
      itemBuilder: (_, int index) {
        return PersonCard(
          person: persons[index],
          onTap: (context) {
            _showModalBottomSheet(context);
          },
          isWide: false,
        );
      },
    );
  }
}

void _showModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      constraints: const BoxConstraints(maxHeight: 200),
      builder: (BuildContext context) {
        return GestureDetector(
          child: const ActionsList(),
          onTap: () {
            Navigator.of(context).pop();
          },
        );
      });
}
