import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;

class MyGlobalObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    dev.log('🚀 Created: ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // This shows you exactly which Cubit moved from State A to State B
    dev.log(
      '🔄 Change in ${bloc.runtimeType}: '
      'From ${change.currentState.runtimeType} '
      'To ${change.nextState.runtimeType}',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    dev.log('❌ Error in ${bloc.runtimeType}: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    dev.log('⚰️ Closed: ${bloc.runtimeType}');
  }
}
