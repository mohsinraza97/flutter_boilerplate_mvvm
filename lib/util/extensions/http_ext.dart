import 'package:http/http.dart' as http;

import '../../data/enums/response_code.dart';
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
      if (code == ResponseCode.timeout.value ||
          code == ResponseCode.internetFailure.value ||
          code == ResponseCode.unknown.value) {
        return Result.error(body, code);
      }

      Result<T> result = Result.parse(_getGenericResponse(body), code, (data) => callback(data));
      result.message ??= '$code - ${this!.reasonPhrase}';
      return result;
    } catch (e) {
      LogUtils.error('API parse exception: ${e.toString()}');
      return Result.error(AppStrings.errorUnknown, code);
    }
  }

  String _getGenericResponse(String? body) {
    /*
    * Use this method only if your BE doesn't provide a generic response for each API.
    * Below are the desired response formats for success/error scenarios
    *
    * { "success": true, "data": {} }
    * { "success": false, "message": "" }
    *
    */

    const start = '{"success":true,"data":';
    const end = '}';
    return '$start$body$end';
  }
}
