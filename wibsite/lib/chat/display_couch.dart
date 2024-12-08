import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wibsite/chat/chatpage.dart';
import 'package:wibsite/chat/chatservice.dart';
import 'package:wibsite/chat/usertile.dart';
import 'package:wibsite/sign_inmoblie/auth.dart';
import 'package:http/http.dart' as http;

class DisplayCouch extends StatefulWidget {
  const DisplayCouch({super.key});

  @override
  _DisplayCouchState createState() => _DisplayCouchState();
}

class _DisplayCouchState extends State<DisplayCouch> {
  final Authservce auth = Authservce();
  final chatservice chat = chatservice();
  final Map<String, String> userRoles = {};

  @override
  void initState() {
    super.initState();
    final currentUserEmail = auth.getcurrentuser()!.email;
    if (currentUserEmail != null) {
      fetchUserRole(currentUserEmail); // Fetch and cache current user's role
    }
  }

  Future<void> fetchUserRole(String email) async {
    if (userRoles.containsKey(email)) return; // Skip if already fetched

    final url = Uri.parse('http://192.168.1.100:3000/pro/$email');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);

        setState(() {
          userRoles[email] = data['role'] ?? ''; // Cache the role
        });
      } else {
        setState(() {
          userRoles[email] = ''; // Default to empty if not found
        });
      }
    } catch (e) {
      setState(() {
        userRoles[email] = ''; // Handle error gracefully
      });
    }
  }

  User? getcurrent() {
    return auth.getcurrentuser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Users',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.teal,
        elevation: 5,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _buildUserList(),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: chat.getuserstream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text(
              "An error occurred!",
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.teal),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              "No users found.",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) =>
              _buildUserTile(snapshot.data![index], context),
        );
      },
    );
  }

  Widget _buildUserTile(Map<String, dynamic> userData, BuildContext context) {
    final email = userData["email"];

    // Fetch role if not already fetched
    fetchUserRole(email);

    // Check cached role
    final currentUserRole = userRoles[auth.getcurrentuser()!.email] ?? '';
    final targetUserRole = userRoles[email] ?? '';

    if (email != auth.getcurrentuser()!.email) {
      // Conditional rendering based on role
      if (currentUserRole == "coutch" && targetUserRole == "user") {
        return _buildTile(email, userData, context);
      } else if (currentUserRole == "user" && targetUserRole == "coutch") {
        return _buildTile(email, userData, context);
      }
    }

    return Container(); // Return empty for unmatched conditions
  }

  Widget _buildTile(
      String email, Map<String, dynamic> userData, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.teal,
          child: Text(
            email[0].toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          email,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: const Text(
          'Tap to chat',
          style: TextStyle(color: Colors.grey),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Chatpage(
                riciveemail: email,
                riciveid: userData["uid"],
              ),
            ),
          );
        },
        trailing: const Icon(
          Icons.chat,
          color: Colors.teal,
        ),
      ),
    );
  }
}
