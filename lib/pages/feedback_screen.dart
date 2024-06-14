import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:manage_waste/provider/feedbacks_provider.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import '../provider/user_details_provider.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _feedbackController  = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _feedback = '';
  double _rating = 0.0;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

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
          title: const Text('Feedback Screen',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white
            ),
          ),
      ),
      body: Consumer<FeedbackProvider>(
        builder: (context, feedback,child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery
                    .of(context)
                    .size
                    .height - AppBar().preferredSize.height - MediaQuery
                    .of(context)
                    .padding
                    .top,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 40,),
                      FutureBuilder<String>(
                        future: CurrentUserProvider().getFirstName(), // Future method to get user's first name from shared preferences
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            // Show a loading indicator while waiting for the data
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text(
                              'Error: ${snapshot.error}',
                              style: TextStyle(color: Colors.red),
                            );
                          } else {
                            _nameController.text = snapshot.data!;
                            // Display the user's first name if data is retrieved successfully
                            return TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Name',
                                border: OutlineInputBorder(),
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 16),
                    FutureBuilder<String>(
                      future: CurrentUserProvider().getUsername(), // Future method to get user's first name from shared preferences
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          // Show a loading indicator while waiting for the data
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text(
                            'Error: ${snapshot.error}',
                            style: TextStyle(color: Colors.red),
                          );
                        } else {
                          _emailController.text = snapshot.data!;
                          // Display the user's first name if data is retrieved successfully
                          return TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _name = snapshot.data!;
                            },
                          );
                        }
                      },
                    ),
                      SizedBox(height: 16),
                      _buildRatingBar(),
                      SizedBox(height: 16),
                      _buildFeedbackField(),
                      SizedBox(height: 20),

                  Container(
                    width: 320,
                    child: ElevatedButton(
                      onPressed: (){
                        if (_formKey.currentState!.validate()) {
                          _email = _emailController.text.trim();
                          _name = _nameController.text.trim();
                          _feedback = _feedbackController.text.trim();

                          Future.delayed(Duration(seconds: 5), (){
                            feedback.createFeedback(message: _feedback, ratings: _rating, context: context);

                            if(feedback.requestSuccessful == true){
                              toastification.show(
                                  context: context,
                                  style: ToastificationStyle.fillColored,
                                  type: ToastificationType.success,
                                  description: RichText(text:  TextSpan(text: feedback.resMessage)),
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
                                  description: RichText(text:   TextSpan(text: feedback.resMessage)),
                                  alignment: Alignment.bottomCenter,
                                  autoCloseDuration: const Duration(seconds: 4),
                                  icon: const Icon(Icons.cancel, color: Colors.white,),
                                  primaryColor: Colors.red[500],
                                  backgroundColor: Colors.white
                              );

                            }

                          });
                        }
                      },
                      child: _isSubmitting ? CircularProgressIndicator() : Text('Submit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          // textStyle: const TextStyle(fontSize: 18, color: Colors.white),
                          backgroundColor: Colors.cyan[700]
                      ),
                    ),
                  )

                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Name',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
      onSaved: (value) {
        _name = value!;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
      onSaved: (value) {
        _email = value!;
      },
    );
  }

  Widget _buildRatingBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Rate our service', style: TextStyle(fontSize: 16)),
        RatingBar.builder(
          initialRating: _rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
        ),
      ],
    );
  }

  Widget _buildFeedbackField() {
    return TextFormField(
      controller: _feedbackController,
      maxLines: 5,
      decoration: InputDecoration(
        labelText: 'Feedback',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your feedback';
        }
        return null;
      },
      onSaved: (value) {
        _feedback = value!;
      },
    );
  }



}
