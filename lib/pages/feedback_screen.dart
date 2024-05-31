import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _feedback = '';
  double _rating = 0.0;
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.cyan[700],
          title: const Text('Feedback Screen',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white
            ),
          ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top,
          ),
          child: IntrinsicHeight(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40,),
                  _buildNameField(),
                  SizedBox(height: 16),
                  _buildEmailField(),
                  SizedBox(height: 16),
                  _buildRatingBar(),
                  SizedBox(height: 16),
                  _buildFeedbackField(),
                  SizedBox(height: 20),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ),
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

  Widget _buildSubmitButton() {
    return Container(
      width: 320,
      child: ElevatedButton(
        onPressed: _isSubmitting ? null : _submit,
        child: _isSubmitting ? CircularProgressIndicator() : Text('Submit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            // textStyle: const TextStyle(fontSize: 18, color: Colors.white),
            backgroundColor: Colors.cyan[700]
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSubmitting = true;
      });

      // Simulate a network request
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isSubmitting = false;
        });
        // Print form data to console
        print('Name: $_name');
        print('Email: $_email');
        print('Rating: $_rating');
        print('Feedback: $_feedback');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Feedback submitted!')),
        );
      });
    }
  }
}
