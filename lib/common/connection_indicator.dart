import 'package:dsb_samples/service/wifi_connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//This is a wrapper of scaffold
class ConnectionIndicator extends ConsumerWidget {
  const ConnectionIndicator({Key? key, required this.child}) : super(key: key);

  //Scaffold
  final Widget child;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var appState = watch(wifiConnectivityServiceProvider);

    return Container(
      child: appState.when(
        data: (status) {
          switch (status) {
            case ConnectivityState.connected:
              return Scaffold(
                appBar: AppBar(
                  title: Text('Hello World'),
                ),
                body: child,
              );

            case ConnectivityState.disconnected:
              return Scaffold(
                appBar: AppBar(
                  title: Text('Hello World'),
                ),
                body: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: double.infinity,
                        color: Colors.red,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          'Network Unavailable',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    child,
                  ],
                ),
              );
            default:
              return Scaffold(
                appBar: AppBar(
                  title: Text('Hello World'),
                ),
                body: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: double.infinity,
                        color: Colors.red,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          'Network Unavailable',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    child,
                  ],
                ),
              );
          }
        },
        loading: () => Scaffold(
          appBar: AppBar(
            title: Text('Hello World'),
          ),
          body: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: double.infinity,
                  color: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Connecting to internet',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              child,
            ],
          ),
        ),
        error: (err, stack) => Scaffold(
          appBar: AppBar(
            title: Text('Connectivity'),
          ),
          body: Center(
            child: Text(
              'Oops Something went wrong!',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
