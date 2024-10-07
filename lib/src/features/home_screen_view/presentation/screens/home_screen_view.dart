import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasae_push_notification_2/src/features/home_screen_view/presentation/cubit/fetch_user_data_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/log/logger.dart';
import '../../../login_system/presentation/cubit/authentication_cubit.dart';
import '../../../login_system/presentation/screens/login_screen_view.dart';
import '../../data/service/request_notification_permission.dart';

class HomeScreenView extends StatefulWidget {
  static String routeName = "/HomeScreenView";

  const HomeScreenView({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchUserDataCubit(),
      child: const HomeScreenView(),
    );
  }

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  void initState() {
    RequestNotificationPermission.requestForNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    String? userDisplayName = currentUser!.displayName;
    String? userEmailName = currentUser.email?.split('@')[0];

    return BlocBuilder<FetchUserDataCubit, FetchUserDataState>(
      builder: (context, state) {
        if (state is FetchUserDataInitial) {
          return Scaffold(
            drawer: Drawer(
              child: Column(
                children: [
                  const Gap(50),
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.yellow,
                  ),
                  const Gap(50),
                  Text("$userEmailName"),
                  const Gap(50),
                  IconButton(
                    onPressed: () {
                      context.read<AuthenticationCubit>().signOutFunction();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        LoginScreenView.routeName,
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.logout),
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              centerTitle: true,
              title: Text(userDisplayName ?? userEmailName!),
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(Icons.person),
                  );
                },
              ),
            ),
            body: StreamBuilder(
              stream: context.read<FetchUserDataCubit>().fetchUser(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (snapshot.hasData) {
                  var documents =
                      (snapshot.data as QuerySnapshot<Map<String, dynamic>>)
                          .docs
                          .where((doc) => doc.data()['uid'] != currentUser.uid)
                          .toList();

                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final userDoc = documents[index];
                      return ListTile(
                        title: Text(userDoc['email'].toString().split("@")[0]),
                        subtitle: Text(userDoc['fcmToken']),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                Log.success("Notification");
                context.read<FetchUserDataCubit>().sendMessageNotification(
                      "Notification Body",
                      "Notification Title",
                      currentUser.uid,
                    );
                await context.read<FetchUserDataCubit>().sendFCMNotification();
                Log.success("Notification");
              },
              child: const Icon(Icons.add),
            ),
          );
        } else if (state is FetchUserDataFailure) {
          return Center(child: Text(state.message));
        } else if (state is FetchUserDataSuccess) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

/*

  // QuerySnapshot<Map<String, dynamic>> data =
                  //     snapshot.data as QuerySnapshot<Map<String, dynamic>>;
                  // List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs =
                  //     data.docs;
                  // Set<String> uniqueSet = {};
                  // List<QueryDocumentSnapshot<Map<String, dynamic>>> uniqueList =
                  //     allDocs
                  //         .where((e) => uniqueSet.add(e.data()['uid']))
                  //         .toList();
                  //
                  // List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
                  //     [];
                  //
                  // for (int i = 0; i < uniqueList.length; i++) {
                  //   if (currentUser.uid != uniqueList[i].data()['uid']) {
                  //     documents.add(uniqueList[i]);
                  //   }
                  // }
                  // final documents = data.docs.where(
                  //   (doc) {
                  //     final email = doc.data()['email'] as String?;
                  //     return email != null && email != currentUser.email;
                  //   },
                  // ).toList();
   body: StreamBuilder(
              stream: context.read<FetchUserDataCubit>().fetchUser(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (snapshot.hasData) {
                  var documents =
                      (snapshot.data as QuerySnapshot<Map<String, dynamic>>)
                          .docs
                          .where((doc) => doc.data()['uid'] != currentUser.uid)
                          .toList();

                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final userDoc = documents[index];

                      // Null safety: Check if the 'email' and 'fcmToken' fields exist
                      String? email = userDoc.data().containsKey('email')
                          ? userDoc['email'].toString().split("@")[0]
                          : 'Unknown User';
                      String? fcmToken = userDoc.data().containsKey('fcmToken')
                          ? userDoc['fcmToken']
                          : 'No FCM Token';

                      return ListTile(
                        title: Text(email),
                        // Default to 'Unknown User' if email is missing
                        subtitle: Text(
                            fcmToken!), // Default to 'No FCM Token' if missing
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
 */
