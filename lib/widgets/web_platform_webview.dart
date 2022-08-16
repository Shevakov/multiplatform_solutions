// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

Widget webView(String link) => WebPlatformWebView(link);

class WebPlatformWebView extends StatelessWidget {
  final String link;
  const WebPlatformWebView(this.link, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = Random().nextInt.toString();

    ui.platformViewRegistry
        .registerViewFactory(id, (int viewId) => IFrameElement()..src = link);

    return HtmlElementView(viewType: id);
  }
}
