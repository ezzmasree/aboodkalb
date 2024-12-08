import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wibsite/home_page/home.dart';
import 'package:wibsite/sign_inmoblie/signin_moblie.dart';

class auth_gate extends StatelessWidget {
  const auth_gate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Home_Page();
          } else
            return signin_mobilState();
        },
        stream: FirebaseAuth.instance.authStateChanges(),
      ),
    );
  }
}
