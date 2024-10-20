part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginWithGoogle extends LoginState {}
final class LoginWithFacebook extends LoginState {}
final class CompleteLogin extends LoginState {}



