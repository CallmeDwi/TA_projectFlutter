import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perhutaniwisata_app/components/my_textfield.dart';
import 'package:perhutaniwisata_app/components/my_button.dart';
import 'package:perhutaniwisata_app/components/square_tile.dart';
import 'package:perhutaniwisata_app/cubit/app_cubit.dart';
import 'package:perhutaniwisata_app/pages/home_page.dart';
import 'package:logger/logger.dart';
import 'package:perhutaniwisata_app/pages/profile_pages/login_page.dart';

import '../../cubit/app_cubit_states.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({Key? key, this.onTap}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final Logger _logger = Logger();

  void daftarPengguna() async {
    _logger
        .i('Mencoba mendaftar pengguna dengan email: ${emailController.text}');
    try {
      if (passwordController.text.length < 6) {
        tampilkanDialogKesalahan('Password harus 6 karakter atau lebih!');
        return;
      }
      if (passwordController.text != confirmPasswordController.text) {
        tampilkanDialogKesalahan('Password tidak cocok!');
        return;
      }

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.uid)
          .set({
        'username': emailController.text.split('@')[0],
        'bio': 'Bio kosong..',
      });

      _logger.i('Pengguna berhasil mendaftar, menampilkan snackbar sukses.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pendaftaran berhasil! Silakan login.'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: BlocProvider.of<AppCubits>(context),
              ),
            ],
            child: LoginPage(),
          ),
        ),
      );
    } catch (e) {
      _logger.e('Kesalahan saat mendaftar: $e');
      tampilkanDialogKesalahan('Email atau password yang dimasukkan salah!');
    }
  }

  void tampilkanDialogKesalahan(String pesanKesalahan) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('Kesalahan Pendaftaran')),
          content: Text(
            pesanKesalahan,
            style: TextStyle(color: Colors.red),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Icon(
                Icons.lock,
                size: 80,
              ),
              const SizedBox(height: 30),
              Text(
                'Buat akun baru!',
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
              const SizedBox(height: 30),
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscuredText: false,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscuredText: true,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Konfirmasi Password',
                obscuredText: true,
              ),
              const SizedBox(height: 25),
              MyButton(
                text: 'Daftar',
                onTap: daftarPengguna,
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Atau lanjutkan dengan',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(thickness: 0.5, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(
                    imagePath: 'img/google.png',
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah punya akun?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Login sekarang',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
