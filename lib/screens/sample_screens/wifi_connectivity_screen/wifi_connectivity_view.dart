import 'package:dsb_samples/common/connection_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WifiConnectivityView extends ConsumerWidget {
  const WifiConnectivityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return ConnectionIndicator(
      child: Center(
        child: Text('Hello World'),
      ),
    );
  }
}
