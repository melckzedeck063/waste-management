import 'package:flutter/material.dart';
import 'package:manage_waste/pages/confirm_payment.dart';

class PaymentIntroductionScreen extends StatelessWidget {
  const PaymentIntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: const Text('Payment Required',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white
            ),
          )
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Our Services!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'To continue using our services and a identified as a valuable customer, you need to pay your bill through AzamPay.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the payment page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ConfirmPayment()),
                  );
                },
                child: const Text('Pay with AzamPay', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  textStyle: const TextStyle(fontSize: 18, color: Colors.white),
                  backgroundColor: Colors.cyan[700]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
