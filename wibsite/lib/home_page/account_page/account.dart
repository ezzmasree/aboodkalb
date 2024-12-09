import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wibsite/home_page/account_page/Edit.dart';
import 'package:wibsite/sign_inmoblie/signin_moblie.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String name = "";
  String email = "";
  String password = "";
  int age = 1;
  int weaight = 1;

  @override
  void initState() {
    super.initState();
    searchById("ezz2002gmail.com"); // Automatically call searchById
  }

  void searchById(String id) async {
    final url = Uri.parse('http://192.168.1.9:3000/pro/$id');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        setState(() {
          name = data['name'] ?? 'No name'; // Extract 'name' from the response
          email = data['email'] ?? 'No email';
          password = data['password'] ?? 'No password';
          age = data['age'] ?? 0;
          weaight = data['weight'] ?? 0;
        });
      } else {
        print('Product not found!');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Color(0xffD5FF5F)),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: const Text(
          'Account',
          style: TextStyle(color: Colors.white),
        ),
        // backgroundColor: Color.fromARGB(255, 35, 33, 33),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            crossAxisAlignment: CrossAxisAlignment.start, // Center horizontally
            children: [
              GestureDetector(
                onTap: () {
                  searchById("ezz2002gmail.com");
                },
                child: const CircleAvatar(
                  radius: 50,
                  backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  backgroundImage: AssetImage("assets/avatar.jpg"),
                  // child: Icon(
                  //   Icons.person,
                  //   color: Colors.white,
                  //   size: 30,
                  // ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                // mainAxisAlignment:
                //     MainAxisAlignment.center, // Center Row contents
                children: [
                  const Icon(Icons.person, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    'Name: $name',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                // mainAxisAlignment:
                //     MainAxisAlignment.center, // Center Row contents
                children: [
                  const Icon(Icons.email, color: Colors.grey),
                  const SizedBox(width: 10),
                  Text(
                    'Email: $email',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                // mainAxisAlignment:
                //     MainAxisAlignment.center, // Center Row contents
                children: [
                  const Icon(Icons.lock, color: Colors.grey),
                  const SizedBox(width: 10),
                  Text(
                    'Password: $password',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                // mainAxisAlignment:
                //     MainAxisAlignment.center, // Center Row contents
                children: [
                  const Icon(Icons.cake, color: Colors.grey),
                  const SizedBox(width: 10),
                  Text(
                    'Age: $age',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                // mainAxisAlignment:
                //     MainAxisAlignment.center, // Center Row contents
                children: [
                  const Icon(Icons.monitor_weight, color: Colors.grey),
                  const SizedBox(width: 10),
                  Text(
                    'Weight: $weaight', // Fix typo from 'weaight' to 'weight'
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                // mainAxisAlignment:
                //     MainAxisAlignment.center, // Center Row contents
                children: [
                  const Icon(Icons.height, color: Colors.grey),
                  const SizedBox(width: 10),
                  Text(
                    'Hight: $weaight', // Fix typo from 'weaight' to 'weight'
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const signin_mobilState()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffD5FF5F),
                    ),
                    child: const Text(
                      'Log Out',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const Edit()), // Replace with your target page
                      );
                      // Add logout functionality or navigate to another page
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffD5FF5F),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
