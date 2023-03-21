// import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';

// enum NetworkStatus { onLine, offline }

// class NetworkStatusService {
//   StreamController<NetworkStatus> networkStatusController =
//       StreamController<NetworkStatus>();

//   NetworkStatusService() {
//     Connectivity().onConnectivityChanged.listen((status) {
//       debugPrint(" status :::$status");
//       networkStatusController.add(_getNetworkStatus(status));
//     });
//   }

//   NetworkStatus _getNetworkStatus(ConnectivityResult status) {
//     return status != ConnectivityResult.mobile ||
//             status != ConnectivityResult.wifi
//         ? NetworkStatus.onLine
//         : NetworkStatus.offline;
//   }

//   void dispose() {
//     networkStatusController.close();
//   }
// }
