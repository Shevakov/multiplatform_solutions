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
  Future<List<Person>>? personList$;

  Future<List<Person>> fetchData() async {
    String data = await fetchFileFromAssets("assets/persons.json");
    List<Person> personList = [];
    final jsonResult = json.decode(data);

    jsonResult.forEach((element) => personList.add(Person.fromMap(element)));

    return personList;
  }

  @override
  void initState() {
    super.initState();

    personList$ = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Person>>(
          future: personList$,
          builder: (BuildContext buildContext, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(
                  child: Text('None'),
                );
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                return LayoutBuilder(
                  builder: ((context, constraints) {
                    return constraints.maxWidth > 720
                        ? WideLayout(persons: snapshot.data)
                        : NarrowLayout(persons: snapshot.data);
                  }),
                );
              default:
                return const SingleChildScrollView(
                  child: Text('Default'),
                );
            }
          }),
    );
  }
}
