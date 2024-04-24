import 'package:flutter/material.dart';
import 'package:manage_waste/pages/privacy_page.dart';
import 'package:manage_waste/pages/profile_page.dart';
import 'package:manage_waste/pages/terms_uses_page.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text("Settings",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'General Settings',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                title: const Text('Notifications'),
                trailing: Switch(
                  value: true, // Example value, replace with actual setting value
                  onChanged: (bool value) {
                    // Handle switch change
                  },
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                title: Text('Privacy Policy'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PrivacyPolicyPage())
                  );
                },
                trailing: Icon(Icons.chevron_right),
              ),
            ),
            const SizedBox(height: 20.0),
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                title: Text('Terms of Service'),
                onTap: () {
                  Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => TermsOfUsePage())
                  );
                },
                trailing: Icon(Icons.chevron_right),
              ),
            ),
            const SizedBox(height: 40.0),
            const Text(
              'Account',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                title: Text('My Account'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage())
                  );
                },
                trailing: Icon(Icons.chevron_right),
              ),
            ),
            const SizedBox(height: 20.0),
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                title: Text('Logout'),
                onTap: () {
                  // Handle logout action
                },
                trailing: Icon(Icons.exit_to_app),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
