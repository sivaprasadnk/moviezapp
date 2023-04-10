import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus { onLine, offline }

class NetworkStatusService {
  static StreamController<NetworkStatus> networkStatusController =
      StreamController<NetworkStatus>();

  NetworkStatusService() {
    Connectivity().onConnectivityChanged.listen((status) {
      networkStatusController.add(getNetworkStatus(status));
    });
  }

  static NetworkStatus getNetworkStatus(ConnectivityResult status) {
    return status != ConnectivityResult.mobile ||
            status != ConnectivityResult.wifi
        ? NetworkStatus.onLine
        : NetworkStatus.offline;
  }

  void dispose() {
    networkStatusController.close();
  }
}
