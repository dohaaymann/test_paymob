part of 'log_out_cubit.dart';

@immutable
sealed class LogOutState {}

final class LogOutInitial extends LogOutState {}
class LogOutloading extends LogOutState {}
class LogOutSuccess extends LogOutState {}
class LogOutFailure extends LogOutState {
  final String error;
  LogOutFailure(this.error);
}

