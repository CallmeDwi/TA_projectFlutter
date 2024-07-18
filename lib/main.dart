import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perhutaniwisata_app/cubit/app_cubit.dart';
import 'package:perhutaniwisata_app/cubit/app_cubit_logics.dart';
import 'package:perhutaniwisata_app/firebase_options.dart';
import 'package:perhutaniwisata_app/pages/auth_page.dart';
import 'package:perhutaniwisata_app/pages/detail_pages/cubit/store_page_info_cubits.dart';
import 'package:perhutaniwisata_app/pages/profile_pages/login_page.dart';
import 'package:perhutaniwisata_app/services/data_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MultiBlocProvider(providers: [
          BlocProvider<AppCubits>(
            create: (context) => AppCubits(
              data: DataServices(),
            ),
          ),
          BlocProvider<StorePageInfoCubits>(
            create: (context) => StorePageInfoCubits(),
          ),
        ], child: AppCubitLogics()));
  }
}
