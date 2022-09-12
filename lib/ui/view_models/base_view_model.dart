import 'package:flutter/material.dart';

import '../../data/enums/data_state.dart';
import '../../data/enums/loading_state.dart';

abstract class BaseViewModel with ChangeNotifier {
  DataState _dataState = DataState.none;
  LoadingState _loadingState = LoadingState.loaded;

  DataState get dataState => _dataState;

  set dataState(DataState state) {
    _dataState = state;
    notifyListeners();
  }

  bool get isLoading => _loadingState == LoadingState.loading;

  @protected
  void toggleLoading(bool loading) {
    if (loading) {
      _loadingState = LoadingState.loading;
    } else {
      _loadingState = LoadingState.loaded;
    }
    notifyListeners();
  }
}
