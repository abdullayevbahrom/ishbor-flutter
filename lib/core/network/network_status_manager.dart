import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';


class NetworkStatusManager {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  NetworkStatusManager._internal();

  static final NetworkStatusManager _instance =
  NetworkStatusManager._internal();

  factory NetworkStatusManager() => _instance;

  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;

  Future<List<ConnectivityResult>> get currentConnectivity =>
      _connectivity.checkConnectivity();

  void startListening(void Function(List<ConnectivityResult>) onConnectivityChanged) {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(onConnectivityChanged);
  }

  void stopListening() {
    _connectivitySubscription?.cancel();
  }
}

