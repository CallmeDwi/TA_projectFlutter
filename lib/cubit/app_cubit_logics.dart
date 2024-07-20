import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perhutaniwisata_app/cubit/app_cubit.dart';
import 'package:perhutaniwisata_app/cubit/app_cubit_states.dart';
import 'package:perhutaniwisata_app/pages/detail_pages/detail_page.dart';
import 'package:perhutaniwisata_app/pages/welcome_page.dart';
import 'package:perhutaniwisata_app/pages/home_page.dart';
import 'package:perhutaniwisata_app/pages/profile_pages/login_page.dart';

class AppCubitLogics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubits, CubitStates>(
      listener: (context, state) {
        if (state is LoginPageState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        } else if (state is LoadedState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else if (state is DetailState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is WelcomeState) {
          return WelcomePage();
        } else if (state is LoadingState) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text('Unexpected state'),
            ),
          );
        }
      },
    );
  }
}
