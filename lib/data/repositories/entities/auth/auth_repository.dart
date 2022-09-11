import '../../../../ui/resources/app_strings.dart';
import '../../../models/entities/user.dart';
import '../../../models/network/requests/auth_request.dart';
import '../../../models/network/responses/auth_response.dart';
import '../../../models/network/result.dart';
import '../../base_repository.dart';

abstract class AuthRepository {
  Future<Result<AuthResponse>> register(RegisterRequest? request);

  Future<Result<AuthResponse>> login(AuthRequest? request);

  Future<User?> getAuthUser();

  Future<void> updateAuthInfo(AuthResponse? response);
}

class AuthRepositoryImpl extends BaseRepositoryImpl implements AuthRepository {
  @override
  Future<Result<AuthResponse>> register(RegisterRequest? request) async {
    if (!await hasInternet()) {
      return Result.error(AppStrings.errorInternetUnavailable);
    }
    return await networkRepository.register(request);
  }

  @override
  Future<Result<AuthResponse>> login(AuthRequest? request) async {
    if (!await hasInternet()) {
      return Result.error(AppStrings.errorInternetUnavailable);
    }
    return await networkRepository.login(request);
  }

  @override
  Future<User?> getAuthUser() async {
    return await storageRepository.getAuthUser();
  }

  @override
  Future<void> updateAuthInfo(AuthResponse? response) async {
    await storageRepository.saveAuthUser(response?.user);
    await storageRepository.saveAuthToken(response?.token);
  }
}
