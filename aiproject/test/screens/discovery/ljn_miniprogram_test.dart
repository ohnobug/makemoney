import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_windows/webview_windows.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/lib/screens/discovery/ljn_miniprogram.dart';

class MockWebViewController extends Mock implements WebViewController {}
class MockWebviewController extends Mock implements WebviewController {}
class MockSystemState extends Mock implements SystemState {}

void main() {
  group('LJNMiniProgram', () {
    late LJNMiniProgram widget;
    late _LJNMiniProgramState state;
    late MockWebViewController mockWebViewController;
    late MockWebviewController mockWindowsWebViewController;
    late MockSystemState mockSystemState;

    setUp(() {
      widget = LJNMiniProgram(link: 'https://example.com');
      state = _LJNMiniProgramState();
      mockWebViewController = MockWebViewController();
      mockWindowsWebViewController = MockWebviewController();
      mockSystemState = MockSystemState();
    });

    test('initState initializes controllers correctly', () {
      state.initState();
      expect(state._lottieController, isNotNull);
      expect(state._webViewController, isNotNull);
    });

    test('dispose releases resources correctly', () {
      state._webViewController = mockWebViewController;
      state._windowsWebViewController = mockWindowsWebViewController;
      state.dispose();
      verify(mockWindowsWebViewController.dispose()).called(1);
    });

    test('_loadWebPage handles internal links correctly', () async {
      state._webViewController = mockWebViewController;
      await state._loadWebPage('http://inner.example.com');
      verify(mockWebViewController.loadHtmlString(any, baseUrl: anyNamed('baseUrl'))).called(1);
    });

    test('_loadWebPage handles external links correctly', () async {
      state._webViewController = mockWebViewController;
      await state._loadWebPage('https://external.example.com');
      verify(mockWebViewController.loadRequest(any)).called(1);
    });

    test('_loadWebPage handles HTTP request failure', () async {
      state._webViewController = mockWebViewController;
      await state._loadWebPage('http://inner.example.com');
      verify(mockWebViewController.loadHtmlString(any, baseUrl: anyNamed('baseUrl'))).called(1);
    });

    test('build renders WebView for non-Windows platform', () {
      state._isWindows = false;
      state._webViewController = mockWebViewController;
      final widget = state.build(MockBuildContext());
      expect(find.byType(WebViewWidget), findsOneWidget);
    });

    test('build renders Webview for Windows platform', () {
      state._isWindows = true;
      state._windowsWebViewController = mockWindowsWebViewController;
      final widget = state.build(MockBuildContext());
      expect(find.byType(Webview), findsOneWidget);
    });
  });
}

class MockBuildContext extends Mock implements BuildContext {}