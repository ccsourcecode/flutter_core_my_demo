import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _NetworkPageState createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  httpClientDemo() async {
    try {
      var httpClient = HttpClient();
      httpClient.idleTimeout = const Duration(seconds: 5);
      var uri = Uri.parse("https://flutter.dev");
      var request = await httpClient.getUrl(uri);
      request.headers.add("user-agent", "Custom-UA");
      var response = await request.close();

      print('Respone code: ${response.statusCode}');
      print(await response.transform(utf8.decoder).join());
    } catch (e) {
      print('Error:$e');
    }
  }

  httpDemo() async {
    try {
      var client = http.Client();
      var uri = Uri.parse("https://flutter.dev");
      http.Response response =
          await client.get(uri, headers: {"user-agent": "Custom-UA"});
      print('Respone code: ${response.statusCode}');
      print(response.body);
    } catch (e) {
      print('Error:$e');
    }
  }

  dioDemo() async {
    try {
      Dio dio = Dio();
      var response = await dio.get("https://flutter.dev",
          options: Options(headers: {"user-agent": "Custom-UA"}));
      print(response.data.toString());
    } catch (e) {
      print('Error:$e');
    }
  }

  dioParallDemo() async {
    try {
      Dio dio = Dio();
      List<Response> responseX = await Future.wait([
        dio.get("https://flutter.dev"),
        dio.get("https://pub.dev/packages/dio")
      ]);

      //打印請求1響應結果
      print("Response1: ${responseX[0].toString()}");
      //打印請求2響應結果
      print("Response2: ${responseX[1].toString()}");
    } catch (e) {
      print('Error:$e');
    }
  }

  dioInterceptorReject() async {
    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      return handler.reject(DioError(
          error: "Error: 攔截的原因",
          requestOptions: RequestOptions(path: options.path)));
    }));

    try {
      var response = await dio.get("https://flutter.dev");
      print(response.data.toString());
    } catch (e) {
      print('Error:$e');
    }
  }

  dioIntercepterCache() async {
    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.resolve(Response(
          requestOptions: RequestOptions(path: options.path, data: "返回緩存數據")));
    }));

    try {
      var response = await dio.get("https://flutter.dev");
      print(response.data.toString());
    } catch (e) {
      print('Error:$e');
    }
  }

  dioIntercepterCustomHeader() async {
    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      options.headers["user-agent"] = "Custom-UA";
      return handler.resolve(Response(
          requestOptions:
              RequestOptions(headers: options.headers, path: options.path)));
    }));

    try {
      var response = await dio.get("https://flutter.dev");
      print(response.data.toString());
    } catch (e) {
      print('Error:$e');
    }
  }

  String jsonString = '''
    {
      "id":"123",
      "name":"張三",
      "score" : 95,
      "teacher": 
         {
           "name": "李四",
           "age" : 40
         }
    }
    ''';

  static Student parseStudent(String content) {
    final jsonResponse = json.decode(content);
    Student student = Student.fromJson(jsonResponse);
    return student;
  }

  Future<Student> loadStudent() {
    return compute(parseStudent, jsonString);
  }

  jsonParseDemo() {
    loadStudent().then((s) {
      String content = '''
        name: ${s.name}
        score:${s.score}
        teacher:${s.teacher.name}
        ''';
      print(content);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextButton(
              child: const Text('HttpClient demo'),
              onPressed: () => httpClientDemo(),
            ),
            TextButton(
              child: const Text('http demo'),
              onPressed: () => httpDemo(),
            ),
            TextButton(
              child: const Text('Dio demo'),
              onPressed: () => dioDemo(),
            ),
            TextButton(
              child: const Text('Dio 併發demo'),
              onPressed: () => dioParallDemo(),
            ),
            TextButton(
              child: const Text('Dio 攔截'),
              onPressed: () => dioInterceptorReject(),
            ),
            TextButton(
              child: const Text('Dio 緩存'),
              onPressed: () => dioIntercepterCache(),
            ),
            TextButton(
              child: const Text('Dio 自定義header'),
              onPressed: () => dioIntercepterCustomHeader(),
            ),
            TextButton(
              child: const Text('JSON解析demo'),
              onPressed: () => jsonParseDemo(),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Student {
  String id;
  String name;
  int score;
  Teacher teacher;

  Student(
      {required this.id,
      required this.name,
      required this.score,
      required this.teacher});
  factory Student.fromJson(Map<String, dynamic> parsedJson) {
    return Student(
        id: parsedJson['id'],
        name: parsedJson['name'],
        score: parsedJson['score'],
        teacher: Teacher.fromJson(parsedJson['teacher']));
  }
}

class Teacher {
  String name;
  int age;
  Teacher({required this.name, required this.age});

  factory Teacher.fromJson(Map<String, dynamic> parsedJson) {
    return Teacher(name: parsedJson['name'], age: parsedJson['age']);
  }
}
