import 'dart:async';

class SessionManager {
  final _sessionController = StreamController<void>.broadcast();

  Stream<void> get onSessionExpired => _sessionController.stream;

  void logout() {
    _sessionController.add(null);
  }
}
