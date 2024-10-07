part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthenticationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthSuccess extends AuthenticationState {
  final User user;
  const AuthSuccess(this.user);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthFailure extends AuthenticationState {
  final String message;
  const AuthFailure(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
