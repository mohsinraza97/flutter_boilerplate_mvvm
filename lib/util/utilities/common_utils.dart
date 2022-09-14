import 'package:flutter/material.dart';
import '../../ui/resources/app_strings.dart';

class CommonUtils {
  const CommonUtils._internal();

  static void showSnackBar(
    BuildContext context,
    String? content, {
    int duration = 2,
    bool actionVisibility = false,
    String actionName = AppStrings.ok,
    VoidCallback? actionCallback,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content ?? ''),
        duration: Duration(seconds: duration),
        action: actionVisibility
            ? SnackBarAction(
                label: actionName.toUpperCase(),
                onPressed: () {
                  if (actionCallback != null) {
                    actionCallback();
                  }
                },
              )
            : null,
      ),
    );
  }

  static void removeCurrentFocus(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Widget getFlatButton(
    String text, {
    Color? color,
    VoidCallback? onPressed,
  }) {
    return FlatButton(
      textColor: color,
      height: 36,
      minWidth: 88,
      onPressed: onPressed,
      child: Text(text.toUpperCase()),
    );
  }
}
