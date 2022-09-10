// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:core_example/main.dart';
import 'package:core_example/features/test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  test('Increase a counter value should be 1', () {
    final counter = Counter();
    counter.increase();
    expect(counter.count, 1);
  });
  test('1+1 should be 2', () {
    expect(1 + 1, 2);
  });

  group('Counter', () {
    test('Increase a counter value should be 1', () {
      final counter = Counter();
      counter.increase();
      expect(counter.count, 1);
    });

    test('Decrease a counter value should be -1', () {
      final counter = Counter();
      counter.decrease();
      expect(counter.count, -1);
    });
  });

  group('fetchTodo', () {
    test('returns a Todo if successful', () async {
      final client = MockClient();

      //使用Mockito注入請求成功的JSON'字段
      when(client.get(Uri.https('https://xxx.com/todos', '/1')))
          .thenAnswer((_) async => http.Response('{"title": "Test"}', 200));
      //驗證請求結果是否為Todo實例
      expect(await fetchTodo(client), isInstanceOf<Todo>());
    });

    test('throws an exception if error', () {
      final client = MockClient();

      //使用Mockito注入請求失敗的Error
      when(client.get(Uri.https('https://xxx.com/todos', '/1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //驗證請求結果是否拋出異常
      expect(fetchTodo(client), throwsException);
    });
  });

  testWidgets('Counter increments UI test', (WidgetTester tester) async {
    //聲明所需要驗證的Widget對象(即MyApp)，並觸發其渲染
    await tester.pumpWidget(const MyApp());

    //查找字符串文本為'0'的Widget，驗證查找成功
    expect(find.text('0'), findsOneWidget);
    //查找字符串文本為'1'的Widget，驗證查找失敗
    expect(find.text('1'), findsNothing);

    //查找'+'按鈕，施加點擊行為
    await tester.tap(find.byIcon(Icons.add));
    //觸發其渲染
    await tester.pump();

    //查找字符串文本為'0'的Widget，驗證查找失敗
    expect(find.text('0'), findsNothing);
    //查找字符串文本為'1'的Widget，驗證查找成功
    expect(find.text('1'), findsOneWidget);
  });
}
