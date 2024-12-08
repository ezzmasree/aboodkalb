// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wibsite/home_page/account_page/Edit.dart';
import 'package:wibsite/home_page/account_page/account.dart';
import 'package:wibsite/home_page/setting_page/HelpSupport.dart';
import 'package:wibsite/home_page/setting_page/linkdevice.dart';
import 'package:wibsite/home_page/setting_page/media.dart';
import 'package:wibsite/home_page/setting_page/notification.dart';
import 'package:wibsite/home_page/setting_page/privcy.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xffD5FF5F)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/150?img=12'), // Sample user image
              ),
              title: Text(
                'Ezz Masre',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              subtitle: Text(
                'No evidence say you try 😜',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            _buildSettingsItem(
              Icons.person,
              'Account',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountPage()),
                );
                // Add action for Account
                print('Account pressed');
              },
            ),
            SizedBox(height: 10),
            _buildSettingsItem(
              Icons.edit,
              'Edit Profile',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Edit()),
                );
                // Add action for Edit Profile
                print('Edit Profile pressed');
              },
            ),
            SizedBox(height: 10),
            _buildSettingsItem(
              Icons.link,
              'Link Device',
              () {
                // Add action for Link Device
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LinkDevicePage()),
                );
              },
            ),
            SizedBox(height: 10),
            _buildSettingsItem(
              Icons.photo,
              'Media',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FitnessMediaPage()),
                );
                // Add action for Media
                print('Media pressed');
              },
            ),
            SizedBox(height: 10),
            _buildSettingsItem(
              Icons.notifications,
              'Notifications',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationsPage()),
                );
                // Add action for Notifications
                print('Notifications pressed');
              },
            ),
            SizedBox(height: 10),
            _buildSettingsItem(
              Icons.lock,
              'Privacy',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrivacyPage()),
                );
                // Add action for Privacy
                print('Privacy pressed');
              },
            ),
            SizedBox(height: 10),
            _buildSettingsItem(
              Icons.chat,
              'Help and support',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpSupportPage()),
                );
                // Add action for Chats
                print('Chats pressed');
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
      IconData icon, String title, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(color: Color(0xff1C1C1E)),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onPressed, // Invoke the function when tapped
      ),
    );
  }
}
