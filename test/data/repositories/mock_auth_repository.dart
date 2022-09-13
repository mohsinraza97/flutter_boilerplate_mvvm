import 'package:collection/collection.dart';
import 'package:flutter_boilerplate_mvvm/data/models/entities/user.dart';
import 'package:flutter_boilerplate_mvvm/data/models/network/requests/auth_request.dart';
import 'package:flutter_boilerplate_mvvm/data/models/network/responses/auth_response.dart';
import 'package:flutter_boilerplate_mvvm/data/models/network/result.dart';
import 'package:flutter_boilerplate_mvvm/data/repositories/entities/auth/auth_repository.dart';

class MockAuthRepositoryImpl extends AuthRepository {
  final emailRegExp = r'^[\w-\+]+(\.[\w]+)*@[\w-]+(\.[\w]+)*(\.[a-zA-Z]{2,})$';

  final Set<User> _userList = {};
  Set<User> get users => _userList;

  AuthResponse? _authInfo;
  AuthResponse? get authInfo => _authInfo;

  @override
  Future<Result<AuthResponse>> register(RegisterRequest? request) async {
    if (request == null) {
      return Result.error('RegisterRequest instance is missing.');
    }
    if (request.name?.isEmpty ?? false) {
      return Result.error('Name must not be null or empty.');
    }

    final result = _validateEmailAndPassword(request);
    if (result.isError) {
      return result;
    }

    final user = _getUserByEmail(request.email);
    if (user != null) {
      return Result.error(
        'A user already exists with email address [${request.email}]',
      );
    }

    final response = AuthResponse.mockRegister(request);
    _userList.add(response.user!);

    return Result.success(response, 'User created successfully!');
  }

  @override
  Future<Result<AuthResponse>> login(AuthRequest? request) async {
    if (request == null) {
      return Result.error('AuthRequest instance is missing.');
    }

    final result = _validateEmailAndPassword(request);
    if (result.isError) {
      return result;
    }

    final user = _getUserByEmail(request.email);
    if (user == null) {
      return Result.error(
        'User does not exist with email address [${request.email}]',
      );
    }

    const validPassword = '12345678';
    if (request.email != user.email || request.password != validPassword) {
      return Result.error('Email or password is incorrect.');
    }

    final response = AuthResponse.mockLogin(user);
    await updateAuthInfo(response);

    return Result.success(response, 'Login successful!');
  }

  @override
  Future<User?> getAuthUser() async => _authInfo?.user;

  @override
  Future<void> logout() async => await updateAuthInfo(null);

  @override
  Future<void> updateAuthInfo(AuthResponse? response) async {
    _authInfo = response;
  }

  Result<AuthResponse> _validateEmailAndPassword(AuthRequest request) {
    if (request.email?.isEmpty ?? false) {
      return Result.error('Email must not be null or empty.');
    }
    if (!RegExp(emailRegExp).hasMatch(request.email ?? '')) {
      return Result.error('Email is not valid');
    }
    if (request.password?.isEmpty ?? false) {
      return Result.error('Password must not be null or empty.');
    }
    if ((request.password?.length ?? 0) < 8) {
      return Result.error('Password must be at least 8 characters long.');
    }
    return Result.success();
  }

  User? _getUserByEmail(String? email) {
    return _userList.toList().firstWhereOrNull((u) => u.email == email);
  }
}
