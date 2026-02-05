import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  Stream<bool> checkRealConnection() async* {
    while (true) {
      try {
        final result = await InternetAddress.lookup('google.com');
        yield result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } on SocketException catch (_) {
        yield false;
      }
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult.isNotEmpty;
  }
}
