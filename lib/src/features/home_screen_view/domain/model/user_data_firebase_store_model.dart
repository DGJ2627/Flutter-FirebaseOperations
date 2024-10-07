import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_data_firebase_store_model.g.dart';

@JsonSerializable()
class UserDataFirebaseStore extends Equatable {
  final String? uid;
  final String? displayName;
  final String? email;
  final String? photoURL;
  final int? phoneNumber;

  const UserDataFirebaseStore(
      this.uid, this.displayName, this.email, this.photoURL, this.phoneNumber);

  factory UserDataFirebaseStore.fromJson(Map<String, dynamic> json) =>
      _$UserDataFirebaseStoreFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataFirebaseStoreToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        uid,
        displayName,
        email,
        photoURL,
        phoneNumber,
      ];
}
