import 'package:flutter/material.dart';

class PrivacyPage extends StatefulWidget {
  @override
  PrivacyPageState createState() => PrivacyPageState();
}

class PrivacyPageState extends State<PrivacyPage> {
  bool _locationServices = true;
  bool _dataSharing = false;
  bool _personalizedAds = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Privacy Settings',
          style: TextStyle(
            color: Color.fromARGB(255, 253, 255, 248),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: Container(
        color: Colors.black, // Black background
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Changed to white
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.location_on,
                  color: Colors.white), // Changed to white
              title: Text(
                'Location Services',
                style: TextStyle(color: Colors.white), // Changed to white
              ),
              subtitle: Text(
                'Allow the app to access your location.',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.7)), // Changed to white
              ),
              trailing: Switch(
                value: _locationServices,
                activeColor: Colors.blue,
                onChanged: (bool value) {
                  setState(() {
                    _locationServices = value;
                  });
                  // Add logic for enabling/disabling location services
                },
              ),
            ),
            ListTile(
              leading:
                  Icon(Icons.share, color: Colors.white), // Changed to white
              title: Text(
                'Data Sharing',
                style: TextStyle(color: Colors.white), // Changed to white
              ),
              subtitle: Text(
                'Allow sharing of your data with third parties.',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.7)), // Changed to white
              ),
              trailing: Switch(
                value: _dataSharing,
                activeColor: Colors.blue,
                onChanged: (bool value) {
                  setState(() {
                    _dataSharing = value;
                  });
                  // Add logic for enabling/disabling data sharing
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.ads_click,
                  color: Colors.white), // Changed to white
              title: Text(
                'Personalized Ads',
                style: TextStyle(color: Colors.white), // Changed to white
              ),
              subtitle: Text(
                'Receive ads based on your activity and interests.',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.7)), // Changed to white
              ),
              trailing: Switch(
                value: _personalizedAds,
                activeColor: Colors.blue,
                onChanged: (bool value) {
                  setState(() {
                    _personalizedAds = value;
                  });
                  // Add logic for enabling/disabling personalized ads
                },
              ),
            ),
            Divider(color: Colors.white), // Changed to white
            ListTile(
              leading:
                  Icon(Icons.delete, color: Colors.white), // Changed to white
              title: Text(
                'Clear Browsing Data',
                style: TextStyle(color: Colors.white), // Changed to white
              ),
              subtitle: Text(
                'Remove your browsing history and cached data.',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.7)), // Changed to white
              ),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: Colors.white), // Changed to white
              onTap: () {
                // Add logic for clearing browsing data
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.security, color: Colors.white), // Changed to white
              title: Text(
                'Manage Permissions',
                style: TextStyle(color: Colors.white), // Changed to white
              ),
              subtitle: Text(
                'Manage permissions granted to the app.',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.7)), // Changed to white
              ),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: Colors.white), // Changed to white
              onTap: () {
                // Add logic for managing app permissions
              },
            ),
          ],
        ),
      ),
    );
  }
}
