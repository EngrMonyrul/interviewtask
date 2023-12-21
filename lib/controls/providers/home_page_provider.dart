import 'package:flutter/foundation.dart';

class HomePageProvider extends ChangeNotifier {
  bool _status = false;

  bool get status => _status;

  void setStatus({required bool value}) {
    _status = value;
    notifyListeners();
  }
}
