import 'package:flutter/material.dart';
import 'package:manage_waste/pages/landing_screen.dart';
import 'package:manage_waste/pages/login_screen.dart';
import 'package:manage_waste/provider/authentication_provider.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignupScreen> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false; // Added to track the loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
          "Sign Up",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Consumer<AuthenticationProvider>(
              builder: (context, auth, child) {
                return Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "Signup Now",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Hi! Create your account now",
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          padding: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: firstnameController,
                            autofocus: false,
                            decoration: const InputDecoration(
                                filled: true,
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Firstname",
                                prefixIcon: Icon(Icons.person)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Firstname is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          padding: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: lastnameController,
                            autofocus: false,
                            decoration: const InputDecoration(
                                filled: true,
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Lastname",
                                prefixIcon: Icon(Icons.person_2)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Lastname is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          padding: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: phoneController,
                            decoration: const InputDecoration(
                                filled: true,
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Telephone (255)",
                                prefixIcon: Icon(Icons.phone)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Telephone is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          padding: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: emailController,
                            autofocus: false,
                            decoration: const InputDecoration(
                                filled: true,
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Email / Username",
                                prefixIcon: Icon(Icons.mail)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          padding: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: passwordController,
                            autofocus: false,
                            obscureText: true,
                            decoration: const InputDecoration(
                                filled: true,
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Password",
                                prefixIcon: Icon(Icons.lock)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          padding: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: confirmPasswordController,
                            autofocus: false,
                            obscureText: true,
                            decoration: const InputDecoration(
                                filled: true,
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Confirm Password",
                                prefixIcon: Icon(Icons.lock)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirm Password is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: ElevatedButton(
                          onPressed: _isLoading  // Disable button if loading
                              ? null
                              : () async {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });

                              String firstName =
                              firstnameController.text.trim();
                              String lastName =
                              lastnameController.text.trim();
                              String phoneNumber =
                              phoneController.text.trim();
                              String email =
                              emailController.text.trim();
                              String password =
                              passwordController.text.trim();
                              String confirmPassword =
                              confirmPasswordController.text.trim();

                              await auth.registerUser(
                                  firstName: firstName,
                                  lastName: lastName,
                                  username: email,
                                  telephone: phoneNumber,
                                  password: password,
                                  context: context);

                              Future.delayed(Duration(seconds: 3), () {
                                setState(() {
                                  _isLoading = false;
                                });

                                if (auth.requestSuccessful == true) {
                                  toastification.show(
                                      context: context,
                                      style: ToastificationStyle
                                          .fillColored,
                                      type: ToastificationType.success,
                                      description: RichText(
                                          text: TextSpan(
                                              text: auth.resMessage)),
                                      alignment: Alignment.topRight,
                                      autoCloseDuration:
                                      const Duration(seconds: 4),
                                      icon: const Icon(
                                          Icons.check_circle),
                                      primaryColor: Colors.green[700],
                                      backgroundColor: Colors.white);
                                } else {
                                  toastification.show(
                                      context: context,
                                      style: ToastificationStyle
                                          .fillColored,
                                      type: ToastificationType.error,
                                      description: RichText(
                                          text: TextSpan(
                                              text: auth.resMessage)),
                                      alignment: Alignment.topRight,
                                      autoCloseDuration:
                                      const Duration(seconds: 4),
                                      icon: const Icon(
                                        Icons.cancel,
                                        color: Colors.white,
                                      ),
                                      primaryColor: Colors.red[500],
                                      backgroundColor: Colors.white);
                                }
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyan[700],
                              padding: const EdgeInsets.all(8)),
                          child: Center(
                            child: _isLoading
                                ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                                : Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const LoginScreen()));
                            },
                            child: Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                "Sign In",
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
