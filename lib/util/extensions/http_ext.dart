import 'package:http/http.dart' as http;

import '../../data/enums/response_type.dart';
import '../../data/models/network/result.dart';
import '../../ui/resources/app_strings.dart';
import '../constants/network_constants.dart';
import '../utilities/log_utils.dart';

extension HttpExtension on http.Response? {
  Result<T> parse<T>(Function(dynamic data) callback) {
    if (this == null) {
      throw Exception('HTTP response received is NULL');
    }
    final code = this!.statusCode;
    final body = this!.body;
    try {
      if (code == ResponseType.timeout.asInt ||
          code == ResponseType.internetFailure.asInt ||
          code == ResponseType.unknown.asInt) {
        return Result.error(body, code);
      }
      return Result.parse(
        _prepareResponseBody(body),
        code,
        (data) => callback(data),
      );
    } catch (e) {
      LogUtils.error('API parse exception: ${e.toString()}');
      return Result.error(AppStrings.errorUnknown, code);
    }
  }

  String _prepareResponseBody(String? body) {
    return '${NetworkConstants.successResponseStart}'
        '${body ?? ''}'
        '${NetworkConstants.successResponseEnd}';
  }
}
