import 'dart:async';
//import 'dart:html';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wifiConnectivityServiceProvider =
    StreamProvider.autoDispose<ConnectivityState>((ref) {
  return WifiConnectivityService().connectivityStreamController.stream;
});

enum ConnectivityState { connected, disconnected }

class WifiConnectivityService {
  //STREAM CONTROLLER
  StreamController<ConnectivityState> connectivityStreamController =
      StreamController<ConnectivityState>();

  //CLASS CONSTRUCTOR
  WifiConnectivityService() {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult? status) async {
      connectivityStreamController.add(
          (await _getConnectivityState(status ?? ConnectivityResult.none)));
    });
  }

  //GET NEW ENUM FOR CONNECTIVITY
  Future<ConnectivityState> _getConnectivityState(
      ConnectivityResult? status) async {
    try {
      //Check actual data connection
      bool isConnected = await DataConnectionChecker().hasConnection;

      switch (status) {
        case ConnectivityResult.mobile:
          if (isConnected == true) {
            return ConnectivityState.connected;
          } else {
            return ConnectivityState.disconnected;
          }
        case ConnectivityResult.wifi:
          if (isConnected == true) {
            return ConnectivityState.connected;
          } else {
            return ConnectivityState.disconnected;
          }
        case ConnectivityResult.none:
          return ConnectivityState.connected;
        default:
          return ConnectivityState.disconnected;
      }
    } on Error catch (_) {
      throw Error();
    }
  }
}
