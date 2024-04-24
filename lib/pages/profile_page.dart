import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
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
        title: const Text("Profile",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            const Center(
              child: CircleAvatar(
                radius: 60,
                // backgroundImage: AssetImage('assets/profile_avatar.jpg'), // Placeholder image
                backgroundColor: Colors.cyan,
              ),
            ),
            const SizedBox(height: 40.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  TextFormField(
                    initialValue: 'John', // Example value, replace with actual value
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: 'Doe', // Example value, replace with actual value
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: 'johndoe123', // Example value, replace with actual value
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: '+1234567890', // Example value, replace with actual value
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: 40.0),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Handle edit profile button tap
                  //   },
                  //   child: Text('Edit Profile'),
                  // ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
