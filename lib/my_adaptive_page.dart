import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:multiplatform_solutions/person.dart';

import 'fetch_file.dart';
import 'widgets/narrow_layout.dart';
import 'widgets/wide_layout.dart';

class MyAdaptivePage extends StatefulWidget {
  const MyAdaptivePage({Key? key}) : super(key: key);

  @override
  State<MyAdaptivePage> createState() => _MyAdaptivePageState();
}

class _MyAdaptivePageState extends State<MyAdaptivePage> {
  Future<String> fetchData() async {
    String data = await fetchFileFromAssets("assets/persons.json");

    final jsonResult = json.decode(data);

    setState(() {
      jsonResult.forEach((element) => personList.add(Person.fromMap(element)));
    });

    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    if (personList.isEmpty) fetchData();

    return Scaffold(
      body: LayoutBuilder(
        builder: ((context, constraints) {
          return constraints.maxWidth > 720
              ? WideLayout(persons: personList)
              : NarrowLayout(persons: personList);
        }),
      ),
    );
  }
}
