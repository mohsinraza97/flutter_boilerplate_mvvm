import '../../../ui/resources/app_strings.dart';
import '../../../util/extensions/numeric_ext.dart';
import '../../../util/utilities/json_utils.dart';
import '../base_model.dart';

class Result<T> implements BaseModel {
  int? code;
  bool? status;
  String? message;
  T? data;

  Result._internal({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  Result.success([this.data, this.message]) {
    code = 200;
    status = true;
  }

  Result.error([this.message, this.code]) {
    status = false;
  }

  bool get isSuccess => (code?.isBetween(200, 299) ?? false) && status == true;

  bool get isError => !isSuccess;

  bool get hasData => data != null;

  String get errorMessage => message ?? AppStrings.errorGeneral;

  factory Result.parse(
    String body,
    int code,
    Function(dynamic data) callback,
  ) {
    final json = JsonUtils.fromJson(body);
    if (json == null) {
      return Result.error();
    }
    return Result<T>._internal(
      code: code,
      status: json['success'],
      message: json['message'],
      data: callback(json['data']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'success': status,
      'message': message,
      'data': data,
    };
  }
}
