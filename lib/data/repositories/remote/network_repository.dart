import 'package:http/http.dart' as http;

import '../../../util/constants/network_constants.dart';
import '../../../util/extensions/http_ext.dart';
import '../../enums/request_type.dart';
import '../../models/network/requests/auth_request.dart';
import '../../models/network/responses/auth_response.dart';
import '../../models/network/result.dart';
import 'network_client.dart';

abstract class NetworkRepository {
  Future<Result<AuthResponse>> register(RegisterRequest? request);

  Future<Result<AuthResponse>> login(AuthRequest? request);
}

class NetworkRepositoryImpl implements NetworkRepository {
  @override
  Future<Result<AuthResponse>> register(RegisterRequest? request) async {
    final response = await NetworkClient.instance.request(
      RequestType.post,
      endpoint: NetworkConstants.register,
      body: request?.toJson(),
    );
    return _handleAuthResult(response);
  }

  @override
  Future<Result<AuthResponse>> login(AuthRequest? request) async {
    final response = await NetworkClient.instance.request(
      RequestType.post,
      endpoint: NetworkConstants.login,
      body: request?.toJson(),
    );
    return _handleAuthResult(response);
  }

  Result<AuthResponse> _handleAuthResult(http.Response? response) {
    return response.parse<AuthResponse>((data) {
      return data != null ? AuthResponse.fromJson(data) : null;
    });
  }
}
