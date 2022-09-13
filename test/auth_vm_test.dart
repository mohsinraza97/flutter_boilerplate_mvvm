import 'package:flutter_boilerplate_mvvm/data/models/network/requests/auth_request.dart';
import 'package:flutter_boilerplate_mvvm/di/injector.dart';
import 'package:flutter_boilerplate_mvvm/ui/view_models/auth/auth_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'data/repositories/mock_auth_repository.dart';

void main() {
  late MockAuthRepositoryImpl repository;
  late AuthViewModel viewModel;
  const validEmail = 'mohsin@yopmail.com';
  const validPassword = '12345678';

  setUpAll(() {
    // Initialize dependency injection
    setupDI();

    // Initialize  repository and view model
    repository = MockAuthRepositoryImpl();
    viewModel = AuthViewModel();

    // inject mock repository
    viewModel.repository = repository;
  });

  group('Sign-up tests', () {
    final requestOne = RegisterRequest(name: null, email: null, password: null);
    final requestTwo = RegisterRequest(name: '', email: '', password: '');
    final requestThree = RegisterRequest(
      name: 'SM Raza',
      email: null,
      password: '',
    );
    final requestFour = RegisterRequest(
      name: 'SM Raza',
      email: 'mohsin',
      password: '12345',
    );
    final requestFive = RegisterRequest(
      name: 'SM Raza',
      email: validEmail,
      password: '12345',
    );
    final requestSix = RegisterRequest(
      name: 'SM Raza',
      email: validEmail,
      password: validPassword,
    );
    final requestSeven = RegisterRequest(
      name: 'Ali Raza',
      email: validEmail,
      password: 'Abcd1234',
    );

    test("Should fail if request is null", () async {
      await validateFailedResultForSignUp(viewModel, null, repository);
    });

    test("Should fail if request values are null", () async {
      await validateFailedResultForSignUp(viewModel, requestOne, repository);
    });

    test("Should fail if request values are empty", () async {
      await validateFailedResultForSignUp(viewModel, requestTwo, repository);
    });

    test("Should fail if email is null & password is empty", () async {
      await validateFailedResultForSignUp(viewModel, requestThree, repository);
    });

    test("Should fail if email is not valid", () async {
      await validateFailedResultForSignUp(viewModel, requestFour, repository);
    });

    test("Should fail if password is not valid", () async {
      await validateFailedResultForSignUp(viewModel, requestFive, repository);
    });

    test("Should pass if request is valid", () async {
      final result = await viewModel.register(requestSix);
      expect(result.isSuccess, true);
      expect(repository.users.length, 1);
    });

    test("Should fail if email is duplicate", () async {
      await validateFailedResultForSignUp(
        viewModel,
        requestSeven,
        repository,
        expectedUsersLength: 1,
      );
    });
  });

  group('Login tests', () {
    final requestOne = AuthRequest(email: null, password: null);
    final requestTwo = AuthRequest(email: '', password: '');
    final requestThree = AuthRequest(
      email: null,
      password: '',
    );
    final requestFour = AuthRequest(
      email: 'mohsin',
      password: '12345',
    );
    final requestFive = AuthRequest(
      email: validEmail,
      password: '12345',
    );
    final requestSix = AuthRequest(
      email: validEmail,
      password: 'IncorrectPassword123',
    );
    final requestSeven = AuthRequest(
      email: validEmail,
      password: validPassword,
    );

    test("Should fail if request is null", () async {
      await validateFailedResultForLogin(viewModel, null, repository);
    });

    test("Should fail if request values are null", () async {
      await validateFailedResultForLogin(viewModel, requestOne, repository);
    });

    test("Should fail if request values are empty", () async {
      await validateFailedResultForLogin(viewModel, requestTwo, repository);
    });

    test("Should fail if email is null & password is empty", () async {
      await validateFailedResultForLogin(viewModel, requestThree, repository);
    });

    test("Should fail if email is not valid", () async {
      await validateFailedResultForLogin(viewModel, requestFour, repository);
    });

    test("Should fail if password is not valid", () async {
      await validateFailedResultForLogin(viewModel, requestFive, repository);
    });

    test("Should fail if credentials are incorrect", () async {
      await validateFailedResultForLogin(viewModel, requestSix, repository);
    });

    test("Should pass if credentials are correct", () async {
      final result = await viewModel.login(requestSeven);
      expect(result.isSuccess, true);
    });
  });

  group('Get authenticated user tests', () {
    test("Should pass if email is authenticated", () async {
      final result = await viewModel.getAuthUser();
      expect(result?.email, validEmail);
    });
  });

  group('Logout tests', () {
    test("Should pass if authenticated user data is cleared", () async {
      await viewModel.logout();
      expect(repository.authInfo, null);
    });
  });
}

Future<void> validateFailedResultForSignUp(
  AuthViewModel viewModel,
  RegisterRequest? request,
  MockAuthRepositoryImpl repository, {
  int expectedUsersLength = 0,
}) async {
  final result = await viewModel.register(request);
  expect(result.isSuccess, false);
  expect(repository.users.length, expectedUsersLength);
}

Future<void> validateFailedResultForLogin(
  AuthViewModel viewModel,
  AuthRequest? request,
  MockAuthRepositoryImpl repository,
) async {
  final result = await viewModel.login(request);
  expect(result.isSuccess, false);
  expect(repository.authInfo, null);
}
