import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:perhutaniwisata_app/cubit/app_cubit.dart';
import 'package:perhutaniwisata_app/cubit/app_cubit_states.dart';

import 'home_page.dart';
import 'profile_pages/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            context.read<AppCubits>().goHome(); // Trigger Cubit to go to Home
          } else {
            context
                .read<AppCubits>()
                .goToLoginPage(); // Trigger Cubit to go to Login Page
          }

          return BlocBuilder<AppCubits, CubitStates>(
            builder: (context, state) {
              if (state is LoadedState) {
                return HomePage();
              } else if (state is LoginPageState) {
                return LoginPage();
              } else if (state is LoadingState) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Container(); // Default empty container
              }
            },
          );
        },
      ),
    );
  }
}
