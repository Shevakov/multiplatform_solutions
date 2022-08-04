import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  String cors = '';
  Stream<String>? fileStream;

  Stream<String> getFileContent() async* {
    String path = myController.text;
    var url = Uri.parse(path);

    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        cors = response.headers['Access-Control-Allow-Origin'] ?? 'None';
        String jsonResponse = response.body;
        yield jsonResponse;
      }
    } catch (e) {
      yield 'файл не найден';
    }
  }

  String extractTitle(String html) {
    int startIndex = html.indexOf('<title>');
    int endIndex = html.indexOf('</title>');
    if (startIndex == -1 || endIndex == -1) {
      return '';
    }
    return html.substring(startIndex + 7, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 8,
            child: StreamBuilder(
                stream: fileStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    String title = extractTitle(snapshot.data ?? '');

                    return SingleChildScrollView(
                      child: Column(children: [
                        Text(
                          title,
                          style: const TextStyle(fontSize: 26),
                        ),
                        Text(
                          'CORS Header: $cors',
                          style:
                              const TextStyle(fontSize: 18, color: Colors.red),
                        ),
                        Text(snapshot.data ?? ''),
                      ]),
                    );
                  }
                  return const Text('');
                }),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: myController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              fileStream = getFileContent();
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0))),
                              primary: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                            ),
                            child: const Text('LOAD')),
                      ),
                    ],
                  ),
                  kIsWeb
                      ? const Text('Web')
                      : Text(
                          'APPLICATION RUNNING ON ${Platform.operatingSystem}'),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
