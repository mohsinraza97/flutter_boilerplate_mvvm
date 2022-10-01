import 'package:flutter/material.dart';

import '../../data/enums/ui_state.dart';
import '../../data/enums/loading_state.dart';

abstract class BaseViewModel with ChangeNotifier {
  UiState _uiState = UiState.none;
  LoadingState _loadingState = LoadingState.loaded;
  String? _displayMessage;

  UiState get uiState => _uiState;
  bool get isLoading => _loadingState == LoadingState.loading;
  String? get displayMessage => _displayMessage;

  bool get isStateValid => _uiState == UiState.valid;
  bool get isStateNotValid => !isStateValid && _uiState != UiState.none;

  @protected
  set uiState(UiState state) {
    _uiState = state;
    notifyListeners();
  }

  @protected
  void toggleLoading(bool loading) {
    _loadingState = loading ? LoadingState.loading : LoadingState.loaded;
    notifyListeners();
  }

  @protected
  set displayMessage(String? message) {
    _displayMessage = message;
    notifyListeners();
  }

  @protected
  void resetObservers() {
    displayMessage = null;
    uiState = UiState.none;
    notifyListeners();
  }
}
