// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/animations.dart';
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
  bool isloading = true;
  final Dio dio = Dio();

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            if (mounted) {
              setState(() {
                isloading = true;
              });
            }
          },
          onProgress: (progress) {
            if (mounted) {
              isloading = true;
            }
          },
          onPageFinished: (url) {
            if (mounted) {
              isloading = false;
            }
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
      await controller.loadRequest(
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
          if (isloading == true) Animations.loading,
        ],
      ),
    );
  }
}
