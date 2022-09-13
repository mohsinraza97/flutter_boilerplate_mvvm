import 'package:random_string/random_string.dart';
import 'package:uuid/uuid.dart';

import '../../base_model.dart';
import '../../entities/user.dart';
import '../requests/auth_request.dart';

class AuthResponse implements BaseModel {
  User? user;
  String? token;

  AuthResponse({
    required this.user,
    required this.token,
  });

  factory AuthResponse.mockRegister(RegisterRequest request) {
    return AuthResponse(
      user: User(
        id: const Uuid().v1(),
        name: request.name,
        email: request.email,
        createdAt: DateTime.now().toUtc(),
      ),
      token: randomString(10),
    );
  }

  factory AuthResponse.mockLogin(User user) {
    return AuthResponse(
      user: user,
      token: randomString(10),
    );
  }

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: json['user'] == null ? null : User.fromJson(json['user']),
      token: json['token'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'token': token,
    };
  }
}
