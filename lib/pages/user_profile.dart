import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manage_waste/models/user_model.dart';
import 'package:manage_waste/pages/change_password.dart';
import 'package:manage_waste/provider/authentication_provider.dart';
import 'package:manage_waste/provider/user_details_provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Sample user data
  String profileImageUrl = 'https://via.placeholder.com/150';
  String userName = 'John Doe';
  String userEmail = 'johndoe@example.com';
  String userPhone = '+123456789';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              CurrentUserProvider().logoutUser(context);
            },
          )
        ],
      ),
      body: FutureBuilder<UserModel>(
        future: AuthenticationProvider().getMyProfile(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(
                color: CupertinoColors.activeGreen,
              ),
            );
          }
          else if(snapshot.hasError){
            return Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 40),
                child: Text("Error : ${snapshot.error}",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.red[300]
                  ),
                ),
              ),
            );
          } else if(snapshot.hasData && snapshot.data != null){
            final data =  snapshot.data!.user;
            // print(data);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(profileImageUrl),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text("${data.firstName} ${data.lastName}",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        data.username,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        data.phoneNumber,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                'Personal Information',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ListTile(
                              leading: const Icon(Icons.person),
                              title: const Text('Name'),
                              subtitle: Text("${data.firstName} ${data.lastName}"),
                            ),
                            ListTile(
                              leading: const Icon(Icons.email),
                              title: const Text('Email'),
                              subtitle: Text(data.username),
                            ),
                            ListTile(
                              leading: const Icon(Icons.phone),
                              title: const Text('Phone'),
                              subtitle: Text(data.phoneNumber),
                            ),
                            // Add more user information here
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Handle edit profile action
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit Profile'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChangePasswordPage())
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.cyan[700], backgroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Colors.cyan[700]!),
                        ),
                      ),
                      icon: const Icon(Icons.lock),
                      label: const Text('Change Password'),
                    ),
                  ],
                ),
              ),
            );
          }
          else {
            return  Center(
              child: Text(
                "Oops! Something went wrong",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.red[300]),
              ),
            );
          }
        },
      ),
    );
  }
}
