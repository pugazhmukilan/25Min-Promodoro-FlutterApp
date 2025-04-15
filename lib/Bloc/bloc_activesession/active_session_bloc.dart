import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:promodoro/Hive/SessionObject.dart';

import '../../Hive/AppState.dart';
import '../../Hive/AppState.dart';

part 'active_session_event.dart';
part 'active_session_state.dart';

class ActiveSessionBloc extends Bloc<ActiveSessionEvent, ActiveSessionState> {
  ActiveSessionBloc() : super(ActiveSessionInitial()) {
   on<checkSessionStatus>(_onCheckSessionStatus);
  }


  Future<void> _onCheckSessionStatus(
      ActiveSessionEvent event, Emitter<ActiveSessionState> emit) async {
    final appStateBox = Hive.box<AppState>('appStateBox');
    final sessionBox = Hive.box<PomodoroSession>('sessionsBox');

    if (appStateBox.isEmpty) {
      emit(SessionInactive());
      return;
    }

    final appState = appStateBox.getAt(0);
    if (appState != null &&
        appState.isSessionActive &&
        appState.activeSessionId != null) {
      final session = sessionBox.get(appState.activeSessionId);
      if (session != null) {
        emit(SessionActive(ActiveSession: session));
        return;
      }
    }

    emit(SessionInactive());
  }
}
