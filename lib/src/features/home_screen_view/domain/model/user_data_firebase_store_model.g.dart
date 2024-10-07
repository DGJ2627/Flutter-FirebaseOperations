// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_firebase_store_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataFirebaseStore _$UserDataFirebaseStoreFromJson(
        Map<String, dynamic> json) =>
    UserDataFirebaseStore(
      json['uid'] as String?,
      json['displayName'] as String?,
      json['email'] as String?,
      json['photoURL'] as String?,
      (json['phoneNumber'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserDataFirebaseStoreToJson(
        UserDataFirebaseStore instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'displayName': instance.displayName,
      'email': instance.email,
      'photoURL': instance.photoURL,
      'phoneNumber': instance.phoneNumber,
    };
