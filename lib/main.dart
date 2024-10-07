import 'package:firebasae_push_notification_2/firebase_options.dart';
import 'package:firebasae_push_notification_2/src/core/route/app_route.dart';
import 'package:firebasae_push_notification_2/src/features/home_screen_view/data/service/push_notification.dart';
import 'package:firebasae_push_notification_2/src/features/home_screen_view/presentation/cubit/fetch_user_data_cubit.dart';
import 'package:firebasae_push_notification_2/src/features/login_system/presentation/cubit/authentication_cubit.dart';
import 'package:firebasae_push_notification_2/src/features/login_system/presentation/screens/login_screen_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  MyFirebaseMessagingService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationCubit(),
        ),
        BlocProvider(
          create: (context) => FetchUserDataCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreenView.routeName,
        routes: AppRoute.screens,
      ),
    );
  }
}
