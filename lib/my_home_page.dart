import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

import 'widgets/web_platform_webview.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WebViewController _webViewController;
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

        if (!kIsWeb) {
          _webViewController.loadHtmlString(jsonResponse);
        }

        yield jsonResponse;
      }
    } catch (e) {
      yield 'Ошибка';
    }
  }

  String extractTitle(String html) {
    int startIndex = html.indexOf('<title>');
    int endIndex = html.indexOf('</title>');
    if (startIndex == -1 || endIndex == -1) {
      return '';
    }
    return html.substring(startIndex + 7, endIndex).trim();
  }

  @override
  Widget build(BuildContext context) {
    String platformName = kIsWeb ? 'Web' : Platform.operatingSystem;
    String currentPlatform = 'APPLICATION RUNNING ON $platformName';

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: StreamBuilder(
                  stream: fileStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      String title = extractTitle(snapshot.data ?? '');

                      return Column(children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            title,
                            style: const TextStyle(fontSize: 26),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'CORS Header: $cors',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.red),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: kIsWeb
                              ? WebPlatformWebView(snapshot.data)
                              : WebView(
                                  onWebViewCreated:
                                      (WebViewController webViewController) {
                                    _webViewController = webViewController;
                                  },
                                ),
                        ),
                      ]);
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
                    Row(
                      children: [Text(currentPlatform)],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
