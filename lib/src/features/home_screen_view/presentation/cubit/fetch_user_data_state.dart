part of 'fetch_user_data_cubit.dart';

sealed class FetchUserDataState extends Equatable {
  const FetchUserDataState();
}

class FetchUserDataInitial extends FetchUserDataState {
  @override
  List<Object> get props => [];
}

class FetchUserDataLoading extends FetchUserDataState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchUserDataSuccess extends FetchUserDataState {
  final UserDataFirebaseStore userData;
  const FetchUserDataSuccess(this.userData);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchUserDataFailure extends FetchUserDataState {
  final String message;
  const FetchUserDataFailure(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
