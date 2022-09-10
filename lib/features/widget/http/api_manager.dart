import 'dart:convert';
import 'dart:developer';

import './api_model.dart';
import 'package:http/http.dart' as http;

/// Android calls the http://10.0.2.2:3000/auth endpoint.
///
/// IOS calls the http://localhost:3000/auth endpoint.
abstract class ApiDataSource {
  /// Create new user.
  Future<String> createUser(User body);

  /// Get user info id, username, passowrd
  Future<String> getUser(int id);

  /// Update user data
  Future<String> updateUser(int id, User body);
}

class UserRepository implements ApiDataSource {
  final client = http.Client();
  final String domain = "https://swapi.dev/api/films/1/";

  @override
  Future<String> createUser(User body) {
    return _createUser(
      Uri.parse('$domain/auth'),
      body,
    );
  }

  Future<String> _createUser(
    Uri url,
    User body,
  ) async {
    try {
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body.toJson(),
      );
      if (response.statusCode == 201) {
        log(
          response.body,
          name: response.statusCode.toString(),
        );
        return response.body;
      } else {
        return response.body;
      }
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String> getUser(id) {
    print('getUser');
    return _getUser(
      Uri.parse('$domain/auth/$id'),
    );
  }

  Future<String> _getUser(
    Uri url,
  ) async {
    try {
      final response = await client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print('response.body1 $response');
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      print('response.body3 $result');
      if (response.statusCode == 200) {
        print('response.body2 $response.body');
        log(
          response.body,
          name: response.statusCode.toString(),
        );
        return response.body;
      } else {
        return response.body;
      }
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String> updateUser(int id, User body) {
    return _updateUser(
      Uri.parse('$domain/auth/$id'),
      body,
    );
  }

  Future<String> _updateUser(
    Uri url,
    User body,
  ) async {
    try {
      final response = await client.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body.toJson(),
      );
      if (response.statusCode == 200) {
        log(
          response.body,
          name: response.statusCode.toString(),
        );
        return response.body;
      } else {
        return response.body;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
