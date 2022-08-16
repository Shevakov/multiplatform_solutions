import 'dart:ui' as ui;
import 'dart:html' as htmls;

import 'package:flutter/widgets.dart';

class WebPlatformWebView extends StatelessWidget {
  final String html;
  const WebPlatformWebView(this.html, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: undefined_prefixed_name
    htmls.ui.platformViewRegistry.registerViewFactory(
        'test-view-type',
        (int viewId) => htmls.IFrameElement()
          ..querySelector('body')
          ..innerHtml = html);

    return const HtmlElementView(viewType: 'test-view-type');
  }
}
