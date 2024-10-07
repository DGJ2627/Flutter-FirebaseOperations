import 'package:firebasae_push_notification_2/src/features/home_screen_view/presentation/screens/home_screen_view.dart';
import 'package:firebasae_push_notification_2/src/features/login_system/presentation/screens/login_screen_view.dart';
import 'package:firebasae_push_notification_2/src/features/login_system/presentation/screens/sign_up_screen_view.dart';
import 'package:flutter/cupertino.dart';

class AppRoute {
  static Map<String, WidgetBuilder> get screens => <String, WidgetBuilder>{
        LoginScreenView.routeName: LoginScreenView.builder,
        SignUpScreenView.routeName: SignUpScreenView.builder,
        HomeScreenView.routeName: HomeScreenView.builder,
      };
}
