import 'package:enum_to_string/enum_to_string.dart';
import 'package:page_transition/page_transition.dart';

import '../base_model.dart';

class PageArguments implements BaseModel {
  PageTransitionType? transitionType;
  dynamic data;

  PageArguments({
    this.transitionType,
    this.data,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'Transition': _getTransition(),
      'Data': _getData(),
    };
  }

  String? _getTransition() {
    return transitionType != null
        ? EnumToString.convertToString(transitionType)
        : null;
  }

  dynamic _getData() {
    if (data is BaseModel) {
      return (data as BaseModel).toJson();
    }
    return data;
  }
}
