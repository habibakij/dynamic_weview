import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:qr_test/screen/dashboard_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:get/get.dart';
import '../controller/login_controller.dart';
import '../transition/enum.dart';
import '../transition/page_transition.dart';
import '../utils/common.dart';

class WebViewExample extends StatefulWidget {
  String url, token;
  WebViewExample(this.url, this.token, {super.key});
  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  final loginController = Get.put(LoginController());
  late final WebViewController _controller;

/*String sessionToken = "";
  void getData() async {
    sessionToken = await Common.getShareData("token");
    log("check_login_token: $sessionToken");
  }*/

  @override
  void initState() {
    super.initState();
    //getData();
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    final WebViewController controller = WebViewController.fromPlatformCreationParams(params);
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..enableZoom(true)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('webview_progress : $progress%');
          },
          onPageStarted: (String url) {
            debugPrint('webview_loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Pwebview_loaded: $url');
            loginController.isPageLoaded.value = true;
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(
        Uri.parse(widget.url),
        headers: {"Authorization": "Bearer ${widget.token}"},
      );
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    _controller = controller;
  }

  late InAppWebViewController webView;
  double _zoomLevel = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pushReplacement(PageTransition(child: DashboardScreen(widget.token), type: PageTransitionType.rightToLeft));
          },
        ),
        title: const Text('Ticket Scan'),
        actions: <Widget>[
          NavigationControls(webViewController: _controller),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(widget.url), headers: {"Authorization": "Bearer ${widget.token}"},),
              onWebViewCreated: (controller) {
                webView = controller;
              },
              onLoadStop: (controller, url) {
                log("loading_web: $url");
              },
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
              },
            ),
          ),
          const SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () {
                  _zoomLevel += 0.1;
                  zoomWebView(_zoomLevel);
                },
                child: const Icon(Icons.add, size: 30,),
              ),
              const SizedBox(width: 16.0),
              FloatingActionButton(
                onPressed: () {
                  _zoomLevel -= 0.1;
                  zoomWebView(_zoomLevel);
                },
                child: const Icon(Icons.remove, size: 30,),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
        ],
      ),

      /*body: Column(
        children: [
          Expanded(
            child: Obx(() => Stack(children: [
              WebViewWidget(
                controller: _controller,
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                  Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                  ),
                },
              ),
              if (!loginController.isPageLoaded.value)
                const Center(child: CircularProgressIndicator())
            ])),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () {
                  // Zoom in
                  _zoomLevel += 0.1; // You can adjust the zoom level increment as needed
                  _controller.zoomBy(_zoomLevel);
                },
                child: Icon(Icons.zoom_in),
              ),
              SizedBox(width: 16.0), // Add some spacing between the buttons
              FloatingActionButton(
                onPressed: () {
                  // Zoom out
                  _zoomLevel -= 0.1; // You can adjust the zoom level decrement as needed
                  _controller.zoomBy(_zoomLevel);
                },
                child: Icon(Icons.zoom_out),
              ),
            ],
          ),
        ],
      ),*/


    );
  }
  void zoomWebView(double zoomLevel) {
    final script = """
      document.body.style.zoom = '$zoomLevel';
    """;
    webView.evaluateJavascript(source: script);
  }

}

class NavigationControls extends StatelessWidget {
  const NavigationControls({super.key, required this.webViewController});

  final WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            if (await webViewController.canGoBack()) {
              await webViewController.goBack();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No back history item')),
                );
              }
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () async {
            if (await webViewController.canGoForward()) {
              await webViewController.goForward();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No forward history item')),
                );
              }
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.replay),
          onPressed: () => webViewController.reload(),
        ),
      ],
    );
  }
}
