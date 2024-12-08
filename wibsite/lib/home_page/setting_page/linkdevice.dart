// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LinkDevicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Link Device',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor:
            Color.fromARGB(255, 0, 0, 0), // Using your custom color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Device Code:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 255, 255, 255)),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(
                        255, 255, 255, 255), // Your custom color when focused
                    width: 2.0, // Adjust the width if needed
                  ),
                ),
                border: OutlineInputBorder(),
                //labelText: 'Device Code',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your logic to link the device here
              },
              child: Text('Link Device ',
                  style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffD5FF5F), // Button color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
