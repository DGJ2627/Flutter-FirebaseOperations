import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('userData');

  //sign in method
  Future<void> signInFunction(
      {required String email, required String password}) async {
    try {
      final loginUserCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      emit(AuthSuccess(loginUserCredential.user!));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        emit(AuthFailure(e.message.toString()));
        log('The supplied auth credential is incorrect');
      } else if (e.code == 'user-not-found') {
        emit(const AuthFailure('No user found for that email.'));
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        emit(const AuthFailure('Wrong password provided for that user.'));
        log('Wrong password provided for that user.');
      } else {
        emit(AuthFailure(e.toString()));
        log('Error: ${e.message}');
      }
    }
  }

  //sign up method
  Future<void> signUpFunction(
      {required String email, required String password}) async {
    //User? signUpUser;
    try {
      final signUpUserCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      final signUpUser = signUpUserCredential.user;

      if (signUpUser != null) {
        String? token = await FirebaseMessaging.instance.getToken();

        try {
          await usersCollection.add({
            "uid": signUpUser.uid,
            "fcmToken": token,
            "email": email,
            "phoneNumber": signUpUser.phoneNumber,
            "displayName": signUpUser.displayName ?? "unknown",
            "photoURL": signUpUser.photoURL ?? "no_url",
          });
          log('User data added successfully');
        } catch (e) {
          log('Failed to add user data: $e');
        }

        emit(AuthSuccess(signUpUser));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        emit(AuthFailure(e.message.toString()));
        log('auth credential is incorrect');
      } else {
        emit(AuthFailure(e.toString()));
        log('Error during signup: ${e.message}');
      }
    }
  }

  //google sign in method
  Future<User?> googleSignInFunction() async {
    User? googleSignInUser;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        emit(const AuthFailure("Sign-in canceled"));
        return null;
      }

      final GoogleSignInAuthentication googleAuthentication =
          await googleUser.authentication;

      final googleSignInCredential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication.accessToken,
        idToken: googleAuthentication.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(googleSignInCredential);

      googleSignInUser = userCredential.user;
      String? token = await FirebaseMessaging.instance.getToken();
      DocumentSnapshot userDoc = await fireStore
          .collection('userData')
          .doc(googleSignInUser!.uid)
          .get();

      if (!userDoc.exists) {
        await fireStore.collection('userData').add({
          "uid": googleSignInUser.uid,
          "fcmToken": token,
          "email": googleSignInUser.email,
          "phoneNumber": googleSignInUser.phoneNumber ?? 12345678,
          "displayName": googleSignInUser.displayName ?? "unknown",
          "photoURL": googleSignInUser.photoURL ?? "no_url",
        });
      } else {
        await fireStore.collection('userData').doc(googleSignInUser.uid).set({
          "uid": googleSignInUser.uid,
          "fcmToken": token,
          "email": googleSignInUser.email,
          "phoneNumber": googleSignInUser.phoneNumber ?? 12345678,
          "displayName": googleSignInUser.displayName ?? "unknown",
          "photoURL": googleSignInUser.photoURL ?? "no_url",
        }, SetOptions(merge: true));
      }

      emit(AuthSuccess(googleSignInUser));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        emit(
          AuthFailure(e.message.toString()),
        );
        log('The supplied auth credential is incorrect');
      } else {
        emit(AuthFailure(e.toString()));
        log('Error: ${e.message}');
      }
    }
    return googleSignInUser;
  }

  Future<void> signOutFunction() async {
    try {
      await _auth.signOut();
      await googleSignIn.signOut();
      emit(AuthenticationInitial());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? 'An unknown error occurred'));
    }
  }
}

/*
Future<User?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      emit(const AuthFailure("Sign-in canceled"));
      return null;
    }

    final GoogleSignInAuthentication googleAuthentication =
        await googleUser.authentication;

    final googleSignInCredential = GoogleAuthProvider.credential(
      accessToken: googleAuthentication.accessToken,
      idToken: googleAuthentication.idToken,
    );

    final UserCredential userCredential =
        await _auth.signInWithCredential(googleSignInCredential);

    String? token = await FirebaseMessaging.instance.getToken();

    User user = _createUserFromGoogleSignIn(userCredential.user!, token);
    await _storeUserData(user, token);

    emit(AuthSuccess(user));
    return user;

  } on FirebaseAuthException catch (e) {
    // ... improved error handling (see suggestion 2)
  }
  return null;
}
 */
