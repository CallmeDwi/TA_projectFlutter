import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perhutaniwisata_app/cubit/app_cubit.dart';
import 'package:perhutaniwisata_app/cubit/app_cubit_states.dart';
import 'package:perhutaniwisata_app/pages/detail_pages/detail_page.dart';
import 'package:perhutaniwisata_app/pages/welcome_page.dart';
import 'package:perhutaniwisata_app/pages/home_page.dart'; // Sesuaikan dengan path Anda
import 'package:perhutaniwisata_app/pages/profile_pages/login_page.dart'; // Sesuaikan dengan path Anda

class AppCubitLogics extends StatefulWidget {
  @override
  _AppCubitLogicsState createState() => _AppCubitLogicsState();
}

class _AppCubitLogicsState extends State<AppCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(
      builder: (context, state) {
        if (state is WelcomeState) {
          return WelcomePage();
        } else if (state is LoadedState) {
          return HomePage();
        } else if (state is LoginPageState) {
          return LoginPage();
        } else if (state is DetailState) {
          return DetailPage();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
