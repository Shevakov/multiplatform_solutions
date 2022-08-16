import 'package:flutter/material.dart';
import 'package:multiplatform_solutions/widgets/person_card.dart';
import 'package:popover/popover.dart';

import '../person.dart';
import 'actions_list.dart';

class WideLayout extends StatelessWidget {
  final List<Person> persons;

  const WideLayout({Key? key, required this.persons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            alignment: AlignmentDirectional.topCenter,
            color: Colors.blue,
            child: const Text('Adaptive app'),
          ),
        ),
        Expanded(
          flex: 3,
          child: GridView.builder(
            itemCount: persons.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (_, int index) {
              return PersonCard(
                person: persons[index],
                isWide: true,
                onTap: (context) {
                  showPopover(
                    context: context,
                    transitionDuration: const Duration(milliseconds: 150),
                    bodyBuilder: (context) => GestureDetector(
                      child: const ActionsList(),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    direction: PopoverDirection.bottom,
                    width: 200,
                    height: 200,
                    arrowHeight: 15,
                    arrowWidth: 30,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
