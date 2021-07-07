import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final wifiConnectivityServiceProvider =
    StreamProvider.autoDispose<ConnectivityState>((ref) {
  var connectivityStream =
      WifiConnectivityService().connectivityStreamController.stream;
  ref.onDispose(() => connectivityStream);
  return connectivityStream;
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
      print("Result : $status");
      connectivityStreamController.add(
          (await _getConnectivityState(status ?? ConnectivityResult.none)));
    });
  }

  //GET NEW ENUM FOR CONNECTIVITY
  Future<ConnectivityState> _getConnectivityState(
      ConnectivityResult? status) async {
    try {
      //Check actual data connection
      bool isConnected = await InternetConnectionChecker().hasConnection;

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
          return ConnectivityState.disconnected;
        default:
          return ConnectivityState.disconnected;
      }
    } on Error catch (_) {
      throw Error();
    }
  }
}
