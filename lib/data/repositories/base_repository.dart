import 'package:flutter/material.dart';

import '../../di/injector.dart';
import '../../util/utilities/internet_utils.dart';
import 'local/storage_repository.dart';
import 'remote/network_repository.dart';

abstract class BaseRepository {
  Future<bool> hasInternet();
}

class BaseRepositoryImpl implements BaseRepository {
  @protected
  final networkRepository = injector<NetworkRepository>();
  @protected
  final storageRepository = injector<StorageRepository>();

  @override
  @protected
  Future<bool> hasInternet() async {
    return await InternetUtils.isInternetAvailable();
  }
}
