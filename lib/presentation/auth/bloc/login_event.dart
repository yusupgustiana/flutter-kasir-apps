part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  factory LoginEvent.started() = _Started;
  factory LoginEvent.login({
    required String email,
    required String password,
  }) = _Login;
}
