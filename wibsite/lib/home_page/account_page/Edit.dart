import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wibsite/sign_up_moblie/textfield_signup.dart';
import 'package:http/http.dart' as http;

class Edit extends StatelessWidget {
  const Edit({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController hintPasswordController =
        TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    final TextEditingController weightController = TextEditingController();
    void updateProfile() async {
      // Collect the data from the controllers
      String email = emailController.text;
      String password = passwordController.text;
      String hintPassword = hintPasswordController.text;
      String name = nameController.text;
      String age = ageController.text;
      String weight = weightController.text;

      // Prepare the body for the request
      final Map<String, String> updatedData = {
        'password': password,
        'name': name,
        'age': age,
        'weight': weight,
      };

      // Send the request (you can use your preferred HTTP client here)
      try {
        final response = await http.put(
          Uri.parse('http://192.168.1.100:3000/profile/$email'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(updatedData),
        );

        if (response.statusCode == 200) {
          // Handle success
          print('Profile updated successfully');
        } else {
          // Handle error
          print('Error updating profile');
        }
      } catch (error) {
        print('Error: $error');
      }
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xffD5FF5F)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1B1B1B), Color(0xFF3A3A3A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Edit Your Profile",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffD5FF5F),
                    ),
                  ),
                  const SizedBox(height: 30),
                  textfiled_signupmoblie(
                    icon: Icons.person,
                    controller: nameController,
                    hint: "Edit Your Name",
                    secrt: false,
                  ),
                  const SizedBox(height: 15),
                  textfiled_signupmoblie(
                    icon: Icons.cake,
                    controller: ageController,
                    hint: "Edit Your Age",
                    secrt: false,
                  ),
                  const SizedBox(height: 15),
                  textfiled_signupmoblie(
                    icon: Icons.fitness_center,
                    controller: weightController,
                    hint: "Edit Your Weight",
                    secrt: false,
                  ),
                  const SizedBox(height: 15),
                  textfiled_signupmoblie(
                    icon: Icons.lock,
                    controller: passwordController,
                    hint: "New Password",
                    secrt: true,
                  ),
                  const SizedBox(height: 15),
                  textfiled_signupmoblie(
                    icon: Icons.lock_outline,
                    controller: hintPasswordController,
                    hint: "Confirm Password",
                    secrt: true,
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffD5FF5F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                      fixedSize: const Size(300, 50),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Save Changes",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
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
    );
  }
}
