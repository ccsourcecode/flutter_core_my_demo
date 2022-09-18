class User {
  final String username;
  final String email;
  final String userId;
  final String accessToken;

  User(
      {required this.username,
      required this.email,
      required this.userId,
      required this.accessToken});

  User.fromJson(Map<String, dynamic> data)
      : username = data['username'],
        email = data['email'],
        userId = data['userId'],
        accessToken = data['accessToken'];
}
