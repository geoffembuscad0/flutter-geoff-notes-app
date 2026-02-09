import 'dart:async';
import 'package:flutter/foundation.dart';

class RouterRefreshNotifier extends ChangeNotifier {
  late final StreamSubscription _subscription;

  RouterRefreshNotifier(Stream<dynamic> stream) {
    _subscription = stream.listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
