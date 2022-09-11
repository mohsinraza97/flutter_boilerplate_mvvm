import 'dart:async';
import 'dart:io';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:http/http.dart' as http;

import '../../../ui/resources/app_strings.dart';
import '../../../util/constants/network_constants.dart';
import '../../../util/utilities/json_utils.dart';
import '../../../util/utilities/log_utils.dart';
import '../../enums/request_type.dart';
import '../../enums/response_type.dart';

class NetworkClient {
  const NetworkClient._internal();

  static const NetworkClient _instance = NetworkClient._internal();

  static NetworkClient get instance => _instance;

  Future<http.Response?> request(
    RequestType requestType, {
    required String endpoint,
    String? token,
    Map<String, dynamic>? params,
    dynamic body,
  }) async {
    Exception? exception;
    http.Response? response;
    final uri = _getRequestUri(endpoint, params);

    try {
      final headers = _getHeaders(token);
      body = JsonUtils.toJson(body);

      // Log request
      _logRequest(
        EnumToString.convertToString(requestType),
        uri,
        token: token,
        body: body,
      );

      // Initiate http request
      if (requestType == RequestType.get) {
        response = await http.get(uri, headers: headers);
      } else if (requestType == RequestType.post) {
        response = await http.post(uri, headers: headers, body: body);
      } else if (requestType == RequestType.put) {
        response = await http.put(uri, headers: headers, body: body);
      } else if (requestType == RequestType.patch) {
        response = await http.patch(uri, headers: headers, body: body);
      } else if (requestType == RequestType.delete) {
        response = await http.delete(uri, headers: headers, body: body);
      }
    } on TimeoutException catch (e) {
      // Connection timeout
      exception = e;
      response = http.Response(
        AppStrings.errorTimeout,
        ResponseType.timeout.asInt,
      );
    } on SocketException catch (e) {
      // Internet unavailable
      exception = e;
      response = http.Response(
        AppStrings.errorInternetUnavailable,
        ResponseType.internetFailure.asInt,
      );
    } on Exception catch (e) {
      // Unknown
      exception = e;
      response = http.Response(
        AppStrings.errorUnknown,
        ResponseType.unknown.asInt,
      );
    }

    // Log response
    _logResponse(
      EnumToString.convertToString(requestType),
      uri,
      response: response,
      exception: exception,
    );

    return response;
  }

  Uri _getRequestUri(String endpoint, Map<String, dynamic>? params) {
    final requestUrl = '${NetworkConstants.baseUrl}$endpoint';
    return Uri.parse(requestUrl).replace(queryParameters: params);
  }

  Map<String, String> _getHeaders(String? token) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (token?.isNotEmpty ?? false) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  void _logRequest(
    String requestType,
    Uri uri, {
    String? token,
    dynamic body,
  }) {
    final requestMap = <String, dynamic>{};
    requestMap['Method'] = requestType.toUpperCase();
    requestMap['URL'] = uri.toString();
    requestMap['Headers'] = _getHeaders(token);
    if (body != null) {
      requestMap['Body'] = body;
    }
    LogUtils.debug(requestMap);
  }

  void _logResponse(
    String requestType,
    Uri uri, {
    http.Response? response,
    Exception? exception,
  }) {
    final responseMap = <String, dynamic>{};
    responseMap['Method'] = requestType.toUpperCase();
    responseMap['URL'] = uri.toString();
    responseMap['Response'] = {
      'status': response?.statusCode,
      'phrase': response?.reasonPhrase,
      'body': response?.body,
    };
    if (exception != null) {
      responseMap['Exception'] = exception.toString();
    }
    LogUtils.debug(responseMap);
  }
}
