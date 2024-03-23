import 'package:flutter/material.dart';
import 'package:manage_waste/pages/landing_screen.dart';
import 'package:manage_waste/pages/signup_page.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
            },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text("Sign In",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Sign In",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32
                ),
              ),
              const SizedBox(height: 15),
               Text("Hi! Welcome back you\'ve been missed!",
                style: TextStyle(
                    fontSize: 18,
                  color: Colors.grey[700]
                ),
              ),

              const SizedBox(height: 50),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.mail),
                        hintText: "username"
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock),
                        hintText: "password"
                    ),
                  ),
                ),
              ),

              const  SizedBox(height: 25),
              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 25.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LandingScreen())
                    );
                  },

                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan[700],
                      padding: const EdgeInsets.all(8)
                  ),
                  child: const Center(
                      child: Text("Sign In",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      )),
                ),
              ),


              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don\'t have account?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignupScreen())
                      );
                    },
                    child:  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text("Register now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.cyan[700],
                          fontSize: 18,
                        ),
                      ),
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
