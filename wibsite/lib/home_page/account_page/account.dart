import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:wibsite/home_page/account_page/Edit.dart';

class AccountPage extends StatefulWidget {
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xffD5FF5F)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text(
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
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  backgroundImage: AssetImage("assets/avatar.jpg"),
                  // child: Icon(
                  //   Icons.person,
                  //   color: Colors.white,
                  //   size: 30,
                  // ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                // mainAxisAlignment:
                //     MainAxisAlignment.center, // Center Row contents
                children: [
                  Icon(Icons.person, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'Name: $name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                // mainAxisAlignment:
                //     MainAxisAlignment.center, // Center Row contents
                children: [
                  Icon(Icons.email, color: Colors.grey),
                  SizedBox(width: 10),
                  Text(
                    'Email: $email',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                // mainAxisAlignment:
                //     MainAxisAlignment.center, // Center Row contents
                children: [
                  Icon(Icons.lock, color: Colors.grey),
                  SizedBox(width: 10),
                  Text(
                    'Password: $password',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                // mainAxisAlignment:
                //     MainAxisAlignment.center, // Center Row contents
                children: [
                  Icon(Icons.cake, color: Colors.grey),
                  SizedBox(width: 10),
                  Text(
                    'Age: $age',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                // mainAxisAlignment:
                //     MainAxisAlignment.center, // Center Row contents
                children: [
                  Icon(Icons.monitor_weight, color: Colors.grey),
                  SizedBox(width: 10),
                  Text(
                    'Weight: $weaight', // Fix typo from 'weaight' to 'weight'
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                // mainAxisAlignment:
                //     MainAxisAlignment.center, // Center Row contents
                children: [
                  Icon(Icons.height, color: Colors.grey),
                  SizedBox(width: 10),
                  Text(
                    'Hight: $weaight', // Fix typo from 'weaight' to 'weight'
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Add logout functionality or navigate to another page
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffD5FF5F),
                    ),
                    child: Text(
                      'Log Out',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Edit()), // Replace with your target page
                      );
                      // Add logout functionality or navigate to another page
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffD5FF5F),
                    ),
                    child: Text(
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
