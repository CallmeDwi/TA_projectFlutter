import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perhutaniwisata_app/cubit/app_cubit.dart';
import 'package:perhutaniwisata_app/cubit/app_cubit_states.dart';
import 'package:perhutaniwisata_app/pages/detail_pages/detail_page.dart';
import 'package:perhutaniwisata_app/pages/home_page.dart';
import 'package:perhutaniwisata_app/pages/profile_pages/profile_page.dart';
import 'package:perhutaniwisata_app/pages/welcome_page.dart';

class AppCubitLogics extends StatefulWidget {
  const AppCubitLogics({super.key});

  @override
  State<AppCubitLogics> createState() => _AppCubitLogicsState();
}

class _AppCubitLogicsState extends State<AppCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state) {
          if (state is DetailState) {
            return DetailPage();
          }
          if (state is WelcomeState) {
            return WelcomePage();
          }
          if (state is LoginPageState) {
            return ProfilePage(); // Assuming ProfilePage is where you handle login
          }
          if (state is LoadedState) {
            return HomePage();
          }
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
