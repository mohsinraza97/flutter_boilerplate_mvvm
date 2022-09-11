import 'package:flutter/material.dart';
import '../../data/enums/loading_state.dart';

abstract class BaseViewModel with ChangeNotifier {
  LoadingState loadingState = LoadingState.loaded;

  bool get isLoading => loadingState == LoadingState.loading;

  @protected
  void toggleLoading(bool loading) {
    if (loading) {
      loadingState = LoadingState.loading;
    } else {
      loadingState = LoadingState.loaded;
    }
    notifyListeners();
  }
}
