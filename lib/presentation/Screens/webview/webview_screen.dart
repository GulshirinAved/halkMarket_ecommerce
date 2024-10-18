// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String path;
  final String topTitle;

  const WebViewScreen({
    required this.path,
    required this.topTitle,
    super.key,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;
  var loadingPercentage = 0;
  final Dio dio = Dio();

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
          onWebResourceError: (error) {
            print('WebView encountered an error: $error');
          },
        ),
      );

    _loadWebViewContent();
  }

  Future<void> _loadWebViewContent() async {
    try {
      final response = await dio.get(widget.path);
      controller.loadRequest(
        Uri.dataFromString(
          response.data,
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'),
        ),
      );
    } catch (e) {
      print('Error loading content: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              color: Colors.purple,
              value: loadingPercentage / 100.0,
            ),
        ],
      ),
    );
  }
}
