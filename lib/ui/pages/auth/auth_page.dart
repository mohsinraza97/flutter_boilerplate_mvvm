import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/network/requests/auth_request.dart';
import '../../../data/models/ui/page_arguments.dart';
import '../../../util/constants/route_constants.dart';
import '../../../util/utilities/dialog_utils.dart';
import '../../../util/utilities/navigation_utils.dart';
import '../../resources/app_strings.dart';
import '../../view_models/auth/auth_view_model.dart';
import '../../widgets/common/progress_dialog.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthViewModel? _authVM;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _authVM = Provider.of<AuthViewModel>(context, listen: false);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _onBackPressed();
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    if (_authVM?.isLoading ?? false) {
      return Future.value(false);
    }
    return Future.value(true);
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(AppStrings.appName),
    );
  }

  Widget _buildBody() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      '${_getAuthRequest().toJson()}',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(24),
                  width: constraints.maxWidth,
                  height: 60,
                  child: RaisedButton(
                    onPressed: _loginUser,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    color: Theme.of(context).colorScheme.primary,
                    textColor: Theme.of(context).primaryTextTheme.button?.color,
                    child: Text(
                      AppStrings.login.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Consumer<AuthViewModel>(
              builder: (context, value, child) {
                return ProgressDialog(visible: value.isLoading);
              },
            ),
          ],
        );
      },
    );
  }

  void _loginUser() async {
    final request = _getAuthRequest();
    final result = await _authVM?.login(request);
    if (!mounted) {
      return;
    }
    if (result?.isSuccess ?? false) {
      NavigationUtils.replace(
        context,
        RouteConstants.home,
        args: PageArguments(data: result!.data),
      );
    } else {
      DialogUtils.showErrorDialog(
        context,
        message: result?.message,
      );
    }
  }

  AuthRequest _getAuthRequest() {
    return AuthRequest(
      email: 'ali@yopmail.com',
      password: '12345678',
    );
  }
}
