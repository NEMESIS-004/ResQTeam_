// ignore_for_file: unused_element

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redqteam/Aman_Work/AdminForm/Form/AdminForm.dart';
import 'package:redqteam/Aman_Work/AdminForm/Models/DistrictMapping.dart';
import 'package:redqteam/Aman_Work/Support%20Pages/Pages/AdminMainPage.dart';
import 'package:redqteam/Aman_Work/Support%20Pages/Pages/UserMainPage.dart';
import 'package:redqteam/Aman_Work/Support%20Pages/route_to_either.dart';
import 'package:redqteam/auth/forget_password/forget_password.dart';
import 'package:redqteam/auth/mail_verification/mail_verification_view.dart';
import 'package:redqteam/auth/signup/controller/signup_controller.dart';
import 'package:redqteam/core/firestore_read_write_controller/initial_write.dart';
import 'package:redqteam/ui/HomePage/admin_home_page.dart';
import 'package:redqteam/ui/profile/adminprofilepage.dart';
import 'auth/controller/authentication_controller.dart';
import 'auth/auth_view.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'user_form/user_consent.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeService();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authenticationState = ref.watch(authProvider);
    final signUpState = ref.watch(signUpProvider);
    Widget getHome() {
      if (authenticationState.status == AuthenticationStatus.authenticated) {
        User user = FirebaseAuth.instance.currentUser!;
        InitialWrite.saveUser(user, signUpState);
        if (!user.emailVerified) {
          return const MailVerificationView();
        }
        return RouteToEitherController();
      } else if (authenticationState.status ==
          AuthenticationStatus.unauthenticated) {
        return const AuthView();
      } else {
        return const AuthView();
      }
    }

    return MaterialApp(
      title: 'ResQTeam',
      themeMode: ThemeMode.system,
      theme: FlexThemeData.light(
        scheme: FlexScheme.deepPurple,
      ),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.deepPurple),
      debugShowCheckedModeBanner: false,
      home: getHome(),
      routes: {
        '/forgetpswd': (context) => const ForgotPasswordView(),
        '/adminhomepage': (context) => const AdminMainPage(),
        '/userhomepage': (context) => const UserMainPage(),
        '/adminform': (context) => const AdminForm(),
        '/userform': (context) => const UserConsent(),
      },
    );
  }
}
