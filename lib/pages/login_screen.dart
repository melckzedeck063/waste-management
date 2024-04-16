import 'package:flutter/material.dart';
import 'package:manage_waste/pages/landing_screen.dart';
import 'package:manage_waste/pages/signup_page.dart';
import 'package:manage_waste/provider/authentication_provider.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text("Sign In",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Consumer<AuthenticationProvider>(
              builder: (context, auth,child) {
                return Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        child:
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: emailController,
                            autofocus: false,
                            decoration: const InputDecoration(
                              isDense: true,
                                filled: true,
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.mail),
                                hintText: "username"
                            ),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Username is required";
                              }
                              return null;
                            },
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
                          child: TextFormField(
                            controller: passwordController,
                            autofocus: false,
                            obscureText: true,
                            decoration: const InputDecoration(
                              filled: true,
                                isDense: true,
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.lock),
                                hintText: "password"
                            ),
                            validator: (value){
                              if(value == null ||  value.isEmpty){
                                return "Password is required";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
            
                      const  SizedBox(height: 25),
                      Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 25.0),
                        child: ElevatedButton(
                          onPressed: () {
            
                            if(_formKey.currentState != null && _formKey.currentState!.validate()) {
                              String username = emailController.text.trim();
                              String password =  passwordController.text.trim();
            
                              auth.loginUser(username: username, password: password, context: context);
                            }
            
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
                );
              }
            ),
          )


        ),
      ),
    );
  }
}
