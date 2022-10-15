import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../ui/resources/app_strings.dart';
import 'navigation_utils.dart';

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

  static bool isDrawerOpen(GlobalKey<ScaffoldState>? scaffoldKey) {
    return scaffoldKey?.currentState?.isDrawerOpen ?? false;
  }

  static Future<String> getAppVersion() async {
    PackageInfo package = await PackageInfo.fromPlatform();
    return '${package.version} (${package.buildNumber})';
  }

  static Future<bool> onBackPressed(
    BuildContext context,
    bool? isLoading, {
    Object? result,
  }) async {
    if (isLoading == true) {
      return false;
    }
    NavigationUtils.pop(context, result: result);
    return true;
  }
}
