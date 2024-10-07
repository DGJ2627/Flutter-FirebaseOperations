import 'package:firebasae_push_notification_2/src/features/login_system/presentation/screens/login_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../home_screen_view/presentation/screens/home_screen_view.dart';
import '../cubit/authentication_cubit.dart';

class SignUpScreenView extends StatelessWidget {
  static String routeName = "/SignUpScreenView";

  const SignUpScreenView({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: const SignUpScreenView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (BuildContext context, AuthenticationState state) {
        if (state is AuthSuccess) {
          Navigator.pushNamed(
            context,
            HomeScreenView.routeName,
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AuthFailure) {
          return Scaffold(body: Center(child: Text(state.message)));
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Sign Up",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              centerTitle: true,
            ),
            body: Form(
              key: globalKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                  const Gap(20),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                  const Gap(20),
                  ElevatedButton(
                    onPressed: () {
                      if (globalKey.currentState?.validate() ?? false) {
                        context.read<AuthenticationCubit>().signUpFunction(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                        emailController.clear();
                        passwordController.clear();
                      }
                    },
                    child: const Text("Sign Up"),
                  ),
                  const Gap(20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreenView.routeName);
                    },
                    child: const Text("Sign In"),
                  ),
                  const Gap(20),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<AuthenticationCubit>()
                          .googleSignInFunction();
                    },
                    child: const Text("Google sign in"),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
