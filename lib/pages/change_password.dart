import 'package:flutter/material.dart';
import 'package:manage_waste/provider/authentication_provider.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';


class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

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
          'Account Settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<AuthenticationProvider>(
        builder: (context, auth, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20,),
                    const Text(
                      'Change Your Password',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: _currentPasswordController,
                      obscureText: _obscureCurrentPassword,
                      decoration: InputDecoration(
                        labelText: 'Current Password',
                        border: OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureCurrentPassword ? Icons.visibility : Icons
                                .visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureCurrentPassword = !_obscureCurrentPassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your current password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _newPasswordController,
                      obscureText: _obscureNewPassword,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        border: OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureNewPassword ? Icons.visibility : Icons
                                .visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureNewPassword = !_obscureNewPassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a new password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword ? Icons.visibility : Icons
                                .visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your new password';
                        }
                        if (value != _newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Handle change password logic here
                          String password = _currentPasswordController.text
                              .trim();
                          String newPassword = _newPasswordController.text.trim();
                          String confirmPassword = _confirmPasswordController.text
                              .trim();

                          auth.changePassword(currentPassword: password, newPassword: newPassword, confirmPassword: confirmPassword, context: context);

                          Future.delayed(Duration(seconds: 3), (){

                            if(auth.requestSuccessful == true){
                              toastification.show(
                                  context: context,
                                  style: ToastificationStyle.fillColored,
                                  type: ToastificationType.success,
                                  description: RichText(text:   TextSpan(text: auth.resMessage)),
                                  alignment: Alignment.bottomLeft,
                                  autoCloseDuration: const Duration(seconds: 4),
                                  icon: const Icon(Icons.check_circle),
                                  primaryColor: Colors.green[700],
                                  backgroundColor: Colors.white
                              );
                            }else {
                              toastification.show(
                                  context: context,
                                  style: ToastificationStyle.fillColored,
                                  type: ToastificationType.error,
                                  description: RichText(text:   TextSpan(text: auth.resMessage)),
                                  alignment: Alignment.bottomCenter,
                                  autoCloseDuration: const Duration(seconds: 4),
                                  icon: const Icon(Icons.cancel, color: Colors.white,),
                                  primaryColor: Colors.red[500],
                                  backgroundColor: Colors.white
                              );

                            }

                          });

                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(
                          //       content: Text('Password changed successfully')),
                          // );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan[700],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(
                            fontSize: 18, color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Change Password', style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
