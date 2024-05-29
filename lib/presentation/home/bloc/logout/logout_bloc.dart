import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_kasir_apps/data/data_sources/auth_remote.dart';

part 'logout_bloc.freezed.dart';
part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRemote _authRemote;
  LogoutBloc(
    this._authRemote,
  ) : super(const _Initial()) {
    on<LogoutEvent>((event, emit) async{
      emit(const LogoutState.loading());
      final result = await _authRemote.logout();

      result.fold(
        (l) => emit(LogoutState.error(l)),
        (r) => emit(const LogoutState.success()),
      );
      
    });
  }
}
