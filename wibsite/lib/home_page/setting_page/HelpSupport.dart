import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Help & Support',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading:
                  Icon(Icons.help, color: Colors.white), // Changed to white
              title: Text('FAQs',
                  style: TextStyle(color: Colors.white)), // Changed to white
              trailing: Icon(Icons.arrow_forward_ios,
                  color: Colors.white), // Changed to white
              onTap: () {
                // Navigate to FAQ page
              },
            ),
            Divider(color: Colors.white), // Changed to white
            ListTile(
              leading: Icon(Icons.contact_support,
                  color: Colors.white), // Changed to white
              title: Text('Contact Support',
                  style: TextStyle(color: Colors.white)), // Changed to white
              trailing: Icon(Icons.arrow_forward_ios,
                  color: Colors.white), // Changed to white
              onTap: () {
                // Navigate to contact support page
              },
            ),
            Divider(color: Colors.white), // Changed to white
            ListTile(
              leading:
                  Icon(Icons.info, color: Colors.white), // Changed to white
              title: Text('App Info',
                  style: TextStyle(color: Colors.white)), // Changed to white
              trailing: Icon(Icons.arrow_forward_ios,
                  color: Colors.white), // Changed to white
              onTap: () {
                // Navigate to app info page
              },
            ),
          ],
        ),
      ),
    );
  }
}
