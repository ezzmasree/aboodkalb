import 'package:flutter/material.dart';
import 'package:wibsite/home_page/home.dart';
import 'package:wibsite/saving_data/save_data.dart';
import 'package:wibsite/sign_inmoblie/auth.dart';

import 'package:wibsite/sign_up_moblie/sign_upmoblie.dart';
import 'package:wibsite/sign_up_moblie/textfield_signup.dart';

class signin_mobilState extends StatefulWidget {
  const signin_mobilState({super.key});

  @override
  State<signin_mobilState> createState() => __signin_mobilStateState();
}

class __signin_mobilStateState extends State<signin_mobilState> {
  @override
  String? savedString;

  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController hintPasswordController =
        TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SizedBox.expand(
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(color: Colors.black),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(left: 60, right: 60),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Sign in",
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffD5FF5F),
                        ),
                      ),
                      const SizedBox(height: 20),
                      textfiled_signupmoblie(
                        icon: Icons.email,
                        controller: emailController,
                        hint: "Email",
                        secrt: false,
                      ),
                      const SizedBox(height: 10),
                      textfiled_signupmoblie(
                        icon: Icons.lock,
                        controller: passwordController,
                        hint: "Password",
                        secrt: true,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffD5FF5F),
                          fixedSize: const Size(300, 50),
                        ),
                        onPressed: () async {
                          final authservice = Authservce();

                          try {
                            await saveString(emailController.text);

                            await authservice.sighinwith_eamil(
                              emailController.text,
                              passwordController.text,
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Home_Page(), // Replace with your target page
                              ),
                            );
                          } catch (e) {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                    title: Text("invalid email or password")));
                          }
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => Home_Page()),
                          // );
                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpmoblie()),
                          );
                        },
                        child: const Text(
                          "you dont have account? Sign up",
                          style: const TextStyle(color: Color(0xffD5FF5F)),
                        ),
                      ),
                      const Visibility(
                        visible: false,
                        child: Text(
                          "Please fill in all fields.",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
